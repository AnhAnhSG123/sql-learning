-->>>Exercise 1: Write Queries that Filter Data Using a WHERE Clause-----------
/*Write a SELECT statement that will return the custid, companyname, contactname, address, city, country, and phone columns from the Sales.Customers table. 
Filter the results to include only the customers from the country Canada. */
USE AdventureWorksLT2025
GO

SELECT c.CustomerID , c.LastName, a.AddressLine1, a.CountryRegion, a.City, c.Phone
FROM SalesLT.Customer as c
JOIN SalesLT.CustomerAddress as ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address as a 
ON ca.AddressID = a.AddressID
WHERE CountryRegion = N'Canada'

/*Write a SELECT statement that will return the custid, companyname, contactname, address, city, country, and phone columns from the Sales.Customers table. 
Filter the results to include only customers from the countries Brazil, UK, and USA*/
SELECT c.CustomerID , c.LastName, a.AddressLine1, a.CountryRegion, a.City, c.Phone
FROM SalesLT.Customer as c
JOIN SalesLT.CustomerAddress as ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address as a 
ON ca.AddressID = a.AddressID
WHERE CountryRegion IN (N'Canada',N'United Kingdom')

/*Write a SELECT statement that will return the custid, companyname, contactname, address, city, country, and phone columns from the Sales.Customers table. 
Filter the results to include only the customers with a contact name starting with the letter A.*/
SELECT c.CustomerID , c.LastName, a.AddressLine1, a.CountryRegion, a.City, c.Phone
FROM SalesLT.Customer as c
LEFT JOIN SalesLT.CustomerAddress as ca
ON c.CustomerID = ca.CustomerID
LEFT JOIN SalesLT.Address as a 
ON ca.AddressID = a.AddressID
WHERE c.LastName LIKE N'A%';

SELECT * FROM SalesLT.Customer --return 847 rows

/*Execute the query and notice two things: first, the query retrieves all the rows from the Sales.Customers table. 
Second, there is a comparison operator in the ON clause, specifying that the city column should be equal to the value ‘Toronto’.*/
SELECT c.CustomerID, c.companyname, sh.SalesOrderID
FROM SalesLT.Customer as c
LEFT JOIN SalesLT.SalesOrderHeader as sh
ON c.CustomerID = sh.CustomerID
LEFT JOIN SalesLT.CustomerAddress as ca
ON c.CustomerID = ca.CustomerID
LEFT JOIN SalesLT.Address as a 
ON ca.AddressID = a.AddressID AND a.city = N'Toronto'; --return 857 rows. "Hãy lấy mọi customer, nếu có địa chỉ Toronto thì join vào."

/*Copy the above provided T-SQL statement and modify it to have a comparison operator for the city column in the WHERE clause. Execute the query*/
SELECT c.CustomerID, c.companyname, sh.SalesOrderID
FROM SalesLT.Customer as c
LEFT JOIN SalesLT.SalesOrderHeader as sh
ON c.CustomerID = sh.CustomerID
LEFT JOIN SalesLT.CustomerAddress as ca
ON c.CustomerID = ca.CustomerID
LEFT JOIN SalesLT.Address as a 
ON ca.AddressID = a.AddressID 
WHERE a.City = N'Toronto'; --return 23 rows. "Sau khi join xong, chỉ giữ lại customer có địa chỉ Toronto."

/*Write a T-SQL statement to retrieve customers from the Sales.Customers table that do not have matching orders in the Sales.Orders table. Matching customers with orders is based on a comparison between the customer’s and the order’s custid values. 
Retrieve the custid and companyname columns from the Sales.Customers table. (Hint: Use a T-SQL statement similar to the one in the previous task.)*/
SELECT c.CustomerID, c.companyname, sh.SalesOrderID
FROM SalesLT.Customer as c
LEFT JOIN SalesLT.SalesOrderHeader as sh
ON c.CustomerID = sh.CustomerID
WHERE sh.SalesOrderID IS NULL

-->>>Exercise 2: Write Queries that Sort Data Using an ORDER BY Clause--------------
/*Write a SELECT statement to retrieve the custid and contactname columns from the Sales.Customers table and the orderid and orderdate columns from the Sales.Orders table. 
Filter the results to include only orders placed on or after April 1, 2008 (filter the orderdate column), 
then sort the result by orderdate in descending order and custid in ascending order.*/
SELECT c.CustomerID, c.companyname, sh.SalesOrderID, sh.OrderDate
FROM SalesLT.Customer as c
JOIN SalesLT.SalesOrderHeader as sh
ON c.CustomerID = sh.CustomerID
WHERE sh.OrderDate >= '2008-04-01'
ORDER BY sh.OrderDate DESC , c.CustomerID ASC

--Execute and observe the results
USE HumanResources
GO

SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid, m.lastname AS mgrlastname, m.firstname AS mgrfirstname 
FROM Employees AS e 
INNER JOIN Employees AS m 
ON e.mgrid = m.empid 
WHERE mgrlastname = 'Le'; --must use the source column not the column in SELECT. WHERE evaluated before SELECT

--Apply the needed changes to the SELECT statement so that it will run without an error.
SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid, m.lastname AS mgrlastname, m.firstname AS mgrfirstname 
FROM Employees AS e 
INNER JOIN Employees AS m 
ON e.mgrid = m.empid 
WHERE m.LastName = 'Le';

/*Copy the existing T-SQL statement from previously task and modify it so that the result will return all employees and be ordered by the manager’s first name. 
First, try to use the source column name, and then the alias column name.*/
SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid, m.lastname AS mgrlastname, m.firstname AS mgrfirstname 
FROM Employees AS e 
INNER JOIN Employees AS m 
ON e.mgrid = m.empid 
WHERE m.LastName = 'Le'
ORDER BY m.FirstName -- sap xep theo cot goc trong bang

SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid, m.lastname AS mgrlastname, m.firstname AS mgrfirstname 
FROM Employees AS e 
INNER JOIN Employees AS m 
ON e.mgrid = m.empid 
WHERE m.LastName = 'Le'
ORDER BY mgrfirstname -- sap xep theo cot alias da tao trong SELECT

-->>>Exercise 3: Write Queries that Filter Data Using the TOP Option----------------------
/*Write a SELECT statement against the Sales.Orders table, and retrieve the orderid and orderdate columns. 
Retrieve the 20 most recent orders, ordered by orderdate.*/
USE AdventureWorksLT2025
GO

SELECT TOP(20) SalesOrderID , OrderDate
FROM SalesLT.SalesOrderHeader
ORDER BY OrderDate DESC

--Write a SELECT statement to retrieve the same result as in task 1, but use the OFFSET-FETCH clause.
SELECT SalesOrderID , OrderDate
FROM SalesLT.SalesOrderHeader
ORDER BY OrderDate DESC
OFFSET 0 ROWS 
FETCH FIRST 20 ROWS ONLY

--Write a SELECT statement to retrieve the productname and unitprice columns from the Production.Products table
SELECT p.Name , p.ListPrice
FROM SalesLT.Product AS p 

--Modify the SELECT statement to include only the top 10 percent of products based on unitprice ordering.
SELECT TOP 10 PERCENT p.Name , p.ListPrice
FROM SalesLT.Product AS p 
ORDER BY p.ListPrice DESC

-->>>Exercise 4: Write Queries that Filter Data Using the OFFSET-FETCH Clause----------------------------
/*Write a SELECT statement to retrieve the custid, orderid, and orderdate columns from the Sales.Orders table. 
Order the rows by orderdate and ordered, and then retrieve the first 20 rows. */
SELECT CustomerID, SalesOrderID , OrderDate
FROM SalesLT.SalesOrderHeader
ORDER BY OrderDate, SalesOrderID
OFFSET 0 ROWS
FETCH NEXT 20 rows ONLY

/*Copy the SELECT statement in task 1 and modify the OFFSET-FETCH clause to skip the first 20 rows and fetch the next 20.*/
SELECT CustomerID, SalesOrderID , OrderDate
FROM SalesLT.SalesOrderHeader
ORDER BY OrderDate, SalesOrderID
OFFSET 20 ROWS
FETCH NEXT 20 ROWS ONLY

/*You are given the parameters @pagenum for the requested page number and @pagesize for the requested page size. 
Can you work out how to write a generic form of the OFFSET-FETCH clause using those parameters?*/
DECLARE @pagenum AS INT, @pagesize as INT
SET @pagenum = 3; 
SET @pagesize = 10; 
SELECT CustomerID, SalesOrderID , OrderDate
FROM SalesLT.SalesOrderHeader
ORDER BY OrderDate, SalesOrderID
OFFSET (@pagenum - 1) * @pagesize ROWS FETCH NEXT @pagesize ROWS ONLY; 
