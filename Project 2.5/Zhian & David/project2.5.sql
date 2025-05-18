
--CREATE SCHEMA BACKUP UPDATE------
CREATE SCHEMA BackupData;
GO
-----------------------------------

-------Renaming the table from DATA.SALES to SALE|||||
             --previous name||-new name
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Sales' AND SCHEMA_NAME(schema_id) = 'Data')
BEGIN
    EXEC sp_rename 'Data.Sales', 'Sale';
END;
GO



--RENAME  columns -- Only if it exists
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Data.Sale') AND name = 'SalesID')
    EXEC sp_rename 'Data.Sale.SalesID', 'SaleID', 'COLUMN';
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Data.Sale') AND name = 'TotalSalePrice')
    EXEC sp_rename 'Data.Sale.TotalSalePrice', 'SaleTotal', 'COLUMN';
GO
--END COLUMNS RENAME ---------


--Drop unnecessary columns -- Only if it exists
IF EXISTS (SELECT * 
  FROM sys.columns WHERE object_id = OBJECT_ID('Data.Sale') AND name = 'ID')
  ALTER TABLE [Data].[Sale] DROP COLUMN ID;
GO

--END OF DROP COLUMNS---------


------TRUNCATING START-----------CLEARS the tables-----------------
TRUNCATE TABLE [Data].[Make];
TRUNCATE TABLE [Data].[Sale];
GO
------TRUNCATING END-------------------------




---------CREATING UDT BASED ON THE Normalized table [MAKE]------------
CREATE TYPE [Udt].[MakeName] FROM NVARCHAR(100) NOT NULL;
GO
CREATE TYPE [Udt].[CustomerKey] FROM VARCHAR(10) NOT NULL;
GO
CREATE TYPE [Udt].[InvoiceNumber] FROM CHAR(8) NOT NULL;
GO
CREATE TYPE [Udt].[MoneyAmount] FROM MONEY NULL;
GO


--CLEAN + MODIFY Data.Make DROP column MakeCountry not part of the Normalized design /Form
ALTER TABLE [Data].[Make]  
DROP COLUMN MakeCountry;
GO
ALTER TABLE [DATA].[Make]   ---------UPDATE MakeName to USE it with the UDT created above  
ALTER COLUMN MakeName [Udt].[MakeName];
GO                          ----------UPDATE END-----------------------

--------END OF DROP-----------------------------------------------------------


---------MODIFY START----------- 
-- Adding COUNTRYID to data.MakeID also enforce not NULL
IF COL_LENGTH('Data.Make', 'CountryID') IS NULL
BEGIN
    ALTER TABLE [Data].[Make]
    ADD CountryID [Udt].[SurrogateKeyInt] NULL;
END;
GO

-- Set default value for CountryID if needed
UPDATE [Data].[Make]
SET CountryID = 1
WHERE CountryID IS NULL;
GO

-- Enforce NOT NULL on CountryID
ALTER TABLE [Data].[Make]
ALTER COLUMN CountryID [Udt].[SurrogateKeyInt] NOT NULL;
GO
------------MODIFY END -----------------------------------

-- BEGIN Primary Key constraint on MakeID (if not already exists)------
IF NOT EXISTS (
    SELECT * FROM sys.key_constraints
    WHERE name = 'PK_Make' AND parent_object_id = OBJECT_ID('Data.Make')
)
BEGIN
    ALTER TABLE [Data].[Make]
    ADD CONSTRAINT PK_Make PRIMARY KEY (MakeID);
END;
GO
---END of primary key constraint-----------------------------

-------------------BEGIN unique constraints---------------------

IF NOT EXISTS (
    SELECT * FROM sys.key_constraints
    WHERE name = 'UQ_Make_MakeName' AND parent_object_id = OBJECT_ID('Data.Make')
)
BEGIN
    ALTER TABLE [Data].[Make]
    ADD CONSTRAINT UQ_Make_MakeName UNIQUE (MakeName);
END;
GO


--------------------END unique contraints-----------------------------


--UDT to data.sale columns
ALTER TABLE [Data].[Sale] 
ALTER COLUMN SaleID [Udt].[SurrogateKeyInt];  
GO

ALTER TABLE [Data].[Sale]
ALTER COLUMN CustomerID [Udt].[CustomerKey];
GO

ALTER TABLE [Data].[Sale]
ALTER COLUMN InvoiceNumber [Udt].[InvoiceNumber];
GO

ALTER TABLE [Data].[Sale]
ALTER COLUMN SaleTotal [Udt].[MoneyAmount];
GO


-----END  UDT usage 




------BEGIN ADD CONTRAINTS FOR DATA.SALE----------------------------------------------------
IF NOT EXISTS (
    SELECT * FROM sys.key_constraints WHERE name = 'PK_Sale' AND parent_object_id = OBJECT_ID('Data.Sale'))
BEGIN
    ALTER TABLE [Data].[Sale] ADD CONSTRAINT PK_Sale PRIMARY KEY (SaleID);
END;
GO

IF NOT EXISTS (
    SELECT * FROM sys.key_constraints WHERE name = 'UQ_Sale_InvoiceNumber' AND parent_object_id = OBJECT_ID('Data.Sale'))
BEGIN
    ALTER TABLE [Data].[Sale] ADD CONSTRAINT UQ_Sale_InvoiceNumber UNIQUE (InvoiceNumber);
END;
GO

IF NOT EXISTS (
    SELECT * FROM sys.check_constraints WHERE name = 'CK_Sale_SaleTotal_NonNegative' AND parent_object_id = OBJECT_ID('Data.Sale'))
BEGIN
    ALTER TABLE [Data].[Sale]
    ADD CONSTRAINT CK_Sale_SaleTotal_NonNegative CHECK (SaleTotal IS NULL OR SaleTotal >= 0);
END;
GO
-------END CONTRAINTS-------------------------------------------------------------







---CREATE FLATTEN SCRIPT----

IF OBJECT_ID('dbo.sp_FlattenData', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_FlattenData;
GO
CREATE PROCEDURE [dbo].[sp_FlattenData]
------- Flattening procedure to insert data from flat sources into normalized DATA tables
----- For (Data.Make, Data.Sale)
AS
BEGIN
    -- Example to get the tables row tables
    INSERT INTO [Data].[Make] (MakeName, CountryID)
    SELECT DISTINCT MakeName, 1 FROM [DataTransfer].[Sales2015] WHERE MakeName IS NOT NULL; --jasky i checked if datatransfer exists and sales 2015, they do

    INSERT INTO [Data].[Sale] (CustomerID, InvoiceNumber, SaleTotal, SaleDate) 
    SELECT CustomerID, InvoiceNumber, SalePrice, SaleDate
    FROM [SourceData].[SalesText]
    WHERE CustomerID IS NOT NULL AND InvoiceNumber IS NOT NULL;
END;
GO

EXEC [dbo].[sp_FlattenData];   ----Execution of the flattenData
GO
--END OF THE CREATED FLATTEN SCRIPT 



------PART 2 of project--------make view for tables 

-- View for Make table
CREATE VIEW [Reference].[vw_Make]
AS
SELECT
    MakeID,
    MakeName,
    CountryID
FROM [Data].[Make];
GO

-- View for Sale table
CREATE VIEW [Reference].[vw_Sale]
AS
SELECT
    SaleID,
    CustomerID,
    InvoiceNumber,
    SaleTotal,
    SaleDate
FROM [Data].[Sale];
GO


