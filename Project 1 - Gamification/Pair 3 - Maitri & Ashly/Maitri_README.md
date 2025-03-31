1. A man with a German accent was seen fleeing from the store TSQLV6 after Employee Yael Peled was murdered on Halloween 2020. Find out who did it. 

Ans: CustID 44 - George Louvredis
To find this solution, search the order table and the customer table.

2. A report has been made at TSQLV6 that 3 companies, QZURI, JYPSC, and KSLQF have complained that their orders have never shown up. Find out who was responsible for taking care of their orders. 

Ans: employee 5
To find this, search through the customer table to find the common employee and then the employee table for the solution. 

3. The store TSQLV6 had a raffle recently and the winner was pulled from a box. Due to some unfortunate events, coffee spilled onto the raffle paper and the only information about the winner is that the name contained the letters ‘Kat’ and the phone number contained ‘3456’. Who is the raffle winner?

Ans: Katarina Larsson
Search for the name that contains Kat and the contact number that contains 3456 in the customer table

4. Over at AdventureWorks2019 a notebook was found inside of an Engineer Department. It contained sensitive information so you want to find the owner, however the only clue is a faint 2 letters at the front of the book that looks like “GM”. Find the owner.

Ans: BussnissentID- 9 Gigi Mathew - Research and Dev engineer
This one is tricky since it relies on you guessing that GM is the name initials. Search through the person table for this.

5. Rumors are going around at AdventureWorks2019 that there’s a singing ghost that wanders and haunts the buildings late at night but some say it's a real woman. Get to the bottom of this. Who might have access to all of the departments late at night?

Ans: 229 - Lori Penor - Janitor, ShiftID = 3, DeptID = 13
This question also relies on you making the connection that a janitor might have access to the entire building. You also have to search through the shiftID to find which one matches up at night. Then you search the department history to find who works at night, then search the name in the person table. 

6. A WideWorldImporters ticket has been made about a complaint that CustomerID-33 received their joke mug in the wrong color. Their transaction 28012 had occurred 2015-1-18. Find out the correct color that they were supposed to get so their complaint can be processed quickly. 

Ans: ColorID 3 
Search the stock item transactions from the warehouse and then the colors

7. On 2016-03-07 someone wearing a small Halloween Skull Mask and small pink Furry animal socks from WideWorldImporters was seen stabbing someone to death in an alleyway. Witnesses say the suspect was a woman. After some investigation, a smudged crumpled receipt was found with the address suite 13. Who might the suspect be?

Ans: Aishwarya Dantuluri 1034
Search the orderlines, orders and customers to find the suspect.



Medium Article:
*SQL Server metadata: Unlock the black box of your database schema* 

https://luchiana-dumitrescu25.medium.com/unlock-the-black-box-of-your-database-schema-by-querying-sql-server-metadata-ecf98bfc96a6

This article was really helpful for me because I learned how to query metadata. This was useful because instead of manually searching through many tables to look for one that might match what I was thinking of, I simply write a few lines and get a list back in a few seconds. As opposed to taking minutes to find what I was looking for. 


