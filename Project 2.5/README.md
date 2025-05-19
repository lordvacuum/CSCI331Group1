# Prestige Cars Database Normalization Project

**Date**: November 21, 2024  
**Location**: Y:\Dropbox\CommisionerRoest\DatabaseClass-CSCI331\Projects\Project 2.5 Normalization and UDT\Prestige_Cars_Normalization_Specification-20241121.docx

https://drive.google.com/drive/folders/1VMjbR5dwp7sXF541dkzFtqkinyfSTmnN?usp=drive_link
This Drive link contains all of the individual files for each group member, their own documentation.

All other links are in VideoLinks.md

## Table of Contents
1. [Project Overview](#project-overview)
2. [Schema Design and UDTs](#schema-design-and-udts)
3. [Constraints for Data Integrity](#constraints-for-data-integrity)
4. [Data Cleansing Strategy](#data-cleansing-strategy)
5. [Indexing and Keys](#indexing-and-keys)
6. [ETL Process](#etl-process)
7. [Final Deliverables](#final-deliverables)

## Introduction
This README outlines the normalization process for the Prestige Cars database into a relational database in 3rd Normal Form (3NF). The project focuses on enhancing data integrity, promoting reuse through User-Defined Types (UDTs), and implementing robust constraints for data validation. Deliverables include a database backup file and an annotated presentation.

## Project Overview
The Prestige Cars database normalization project involves restructuring the schema, introducing new tables, and ensuring compliance with database design best practices. The objectives are:
- Schema redesign
- Data cleansing
- Indexing for optimized performance

## Schema Design and UDTs
- Schema names will logically group related tables.
- User-Defined Types (UDTs) will be created for key columns to promote standardization and reuse.
- UDT taxonomy will be guided by examples from the Northwinds Database.

## Constraints for Data Integrity
The database will implement constraints to ensure high data integrity, including:
- Default values for applicable columns
- Mandatory/Optional status for columns
- Unique constraints for key columns
- Business rule validations for custom requirements

## Data Cleansing Strategy
The data cleansing process will:
- Identify and resolve anomalies
- Standardize formats
- Ensure data consistency before migration to the production environment

## Indexing and Keys
- Each table will use primary surrogate keys.
- Non-clustered unique indexes will be implemented to enhance query performance and maintain referential integrity.

## ETL Process
Stored procedures will automate the data transformation process, including:
- Truncating production tables
- Adding and dropping foreign keys dynamically
- Transforming raw data into normalized tables
- Executing the entire ETL process via a single stored procedure

## Final Deliverables
The project deliverables include:
- A backup file (.bak) of the normalized database
- A PowerPoint presentation with voice annotations detailing the design process
- A Word document summarizing the project
