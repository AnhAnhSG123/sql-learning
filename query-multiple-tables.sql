--->>>Exercise 1: Writing Queries That Use Inner Joins------------------------------
USE AdventureWorksLT2025
GO

/*Write a SELECT statement that will return the productname column from the Production.Products table (use table alias “p”) 
and the categoryname column from the Production.Categories table (use table alias “c”) using an inner join.*/

SELECT p.Name as productname, c.ProductCategoryID as categoryid 
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory AS c
ON p.ProductCategoryID = c.ProductCategoryID

-->>>Exercise 2: Writing Queries That Use Multiple-Table Inner Joins----------------------------------
/*Apply the Needed Changes and Execute the T-SQL Statement*/
/*Copy the T-SQL statement from task 2 and modify it to use the table aliases “c” for the Sales.Customers table 
and “o” for the Sales.Orders table.  
Execute the written statement and compare the results with those in task 2. */

SELECT o.CustomerID , c.LastName, o.SalesOrderID 
FROM SalesLT.Customer AS c
INNER join SalesLT.SalesOrderHeader as o
ON c.CustomerID = o.CustomerID; 

/*Copy the T-SQL statement from task 3 and 
modify it to include three additional columns from the Sales.OrderDetails table: productid, qty, and unitprice.*/

SELECT o.CustomerID , c.LastName, o.SalesOrderID, d.ProductID, d.OrderQty, d.UnitPrice 
FROM SalesLT.Customer AS c
join SalesLT.SalesOrderHeader as o
ON c.CustomerID = o.CustomerID
JOIN SalesLT.SalesOrderDetail as d
ON o.SalesOrderID = d.SalesOrderID 

-->>>Exercise 3: Writing Queries That Use Self Joins---------------------------------------------------------------

USE HumanResources
GO

--write a SELECT statement against the HR.Employees table showing the empid, lastname, firstname, title, and mgrid columns
SELECT * FROM Employees

/*Copy the SELECT statement from task 1 and modify it to include additional columns for the manager information 
(lastname, firstname) using a self join. Assign the aliases mgrlastname and mgrfirstname respectively, 
to distinguish the manager names from the employee names. */

SELECT e.* , m.MgrID , m.LastName
FROM Employees AS e 
JOIN Employees as m
ON e.MgrID = m.EmpID --ma quan ly nhan vien bang ma nhan vien cua nguoi quan ly

-->>Exercise 4: Writing Queries That Use Outer Joins------------------------
/*Write a SELECT statement to retrieve the custid and contactname columns from the Sales.Customers table 
and the orderid column from the Sales.Orders table. The statement should retrieve all rows from the Sales.Customers table. */
USE AdventureWorksLT2025
GO

SELECT c.CustomerID, c.LastName, oh.SalesOrderID 
FROM SalesLT.Customer as c
LEFT JOIN SalesLT.SalesOrderHeader as oh
ON c.CustomerID = oh.CustomerID

