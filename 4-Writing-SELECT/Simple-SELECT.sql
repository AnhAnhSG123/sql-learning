-->>>Exercise 1: Writing Simple SELECT Statements-----------------------------------------------------------------------

--Write a SELECT statement that will return all rows and all columns from the Sales.Customers table

SELECT * FROM SalesLT.Customer;

/*Write a SELECT statement to return the contactname, address, postalcode, city, 
and country columns from the Sales.Customers table.*/

SELECT Customer.FirstName , Customer.Phone, Customer.CompanyName
FROM AdventureWorksLT2025.SalesLT.Customer;

-->>>Exercise 2: Eliminating Duplicates Using DISTINCT-----------------------------------------------------------------------

--Write a SELECT statement against the Sales.Address table showing only the country column

SELECT CountryRegion FROM SalesLT.Address

--Copy the SELECT statement in task 1 and modify it to return only distinct values
SELECT DISTINCT CountryRegion FROM SalesLT.Address


-->>>Exercise 3: Using Table and Column Aliases--------------------------------------------------------------------

/*Write a SELECT statement to return the contactname and contacttitle columns from the Sales.Customers table, 
assigning “C” as the table alias.*/

SELECT C.CompanyName, C.Title FROM SalesLT.Customer AS C

/*Write a SELECT statement to return the contactname, contacttitle, and companyname columns. 
Assign these with the aliases Name, Title, and Company Name, respectively, 
to return more human friendly column titles for reporting purposes. */

SELECT C.CompanyName AS COMPANYNAME , C.Title AS CONTACTNAME FROM SalesLT.Customer as C

/*Write a query to display the productname column from the Production.
Products table using “P” as the table alias and Product Name as the column alias.*/

SELECT P.Name AS [PRODUCT NAME]  FROM SalesLT.Product AS P

-->>>>Exercise 4: Using a Simple CASE Expression----------------------------------------------------------------

--Write a SELECT statement to display the categoryid and productname columns from the Production.Products table

SELECT P.Name, P.ProductCategoryID FROM SalesLT.Product AS P

/*Enhance the SELECT statement in task 1 by adding a CASE expression that generates a result column named categoryname. 
The new column should hold the translation of the category ID to its respective category name, 
based on the mapping table supplied earlier. Use the value “Other” for any category IDs not found in the mapping table.*/

SELECT P.Name, P.ProductCategoryID,
	case ProductCategoryID
		when 5 then 'beverages'
		when 6 then 'produce'
		when 7 then 'seafood'
	else 'others'
	end as categoryname
FROM SalesLT.Product AS P
order by ProductCategoryID

/*Modify the SELECT statement in task 2 by adding a new column named iscampaign. 
This will show the description “Campaign Products” for the categories Beverages, Produce, and Seafood, 
and the description “Non-Campaign Products” for all other categories.*/

SELECT P.Name, P.ProductCategoryID,
	case ProductCategoryID
		when 5 then 'beverages'
		when 6 then 'produce'
		when 7 then 'seafood'
		else 'others'
	end as categoryname,
	case 
		when ProductCategoryID in (5,6,7) then 'campaign products'
		else 'non-campain products'
	end as [iscampaign]
FROM SalesLT.Product AS P
order by ProductCategoryID