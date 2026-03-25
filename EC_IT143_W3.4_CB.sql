/*
Script Header
Author:      Carlos Braga
Date:        2026-MAR-25
Purpose:     Answer eight user questions for AdventureWorks2022
Runtime:     Estimated < 2 seconds per query
Database:    AdventureWorks2022
*/

-- =====================================================
-- Marginal Complexity Questions (1 table)
-- =====================================================

-- Q1 (Author: Self)
-- What are the top 10 products with the highest list price?
SELECT TOP 10
    ProductID,
    Name,
    ListPrice
FROM Production.Product
WHERE ListPrice > 0
ORDER BY ListPrice DESC;

-- Q2 (Author: Self)
-- How many customers are currently in the database?
SELECT COUNT(*) AS CustomerCount
FROM Sales.Customer;

-- =====================================================
-- Moderate Complexity Questions (multiple tables)
-- =====================================================

-- Q3 (Author: Self)
-- I need to analyze product performance by category.
-- Show total quantity sold for each product category,
-- sorted highest to lowest.
SELECT 
    pc.Name AS Category,
    SUM(sod.OrderQty) AS TotalQuantity
FROM Production.Product p
INNER JOIN Production.ProductSubcategory ps 
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN Production.ProductCategory pc 
    ON ps.ProductCategoryID = pc.ProductCategoryID
INNER JOIN Sales.SalesOrderDetail sod 
    ON p.ProductID = sod.ProductID
GROUP BY pc.Name
ORDER BY TotalQuantity DESC;

-- Q4 (Author: Self)
-- Please list the top 5 customers by total purchase amount,
-- including their full names and total spent.
SELECT TOP 5
    p.FirstName + ' ' + p.LastName AS CustomerName,
    SUM(sod.LineTotal) AS TotalSpent
FROM Sales.Customer c
INNER JOIN Person.Person p 
    ON c.PersonID = p.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader soh 
    ON c.CustomerID = soh.CustomerID
INNER JOIN Sales.SalesOrderDetail sod 
    ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY p.FirstName, p.LastName
ORDER BY TotalSpent DESC;

-- =====================================================
-- Increased Complexity Questions (story format)
-- =====================================================

-- Q5 (Author: Self)
-- For each product that sold more than 100 units,
-- calculate profit margin percentage as
-- (ListPrice – StandardCost) / ListPrice * 100.
-- Show product name, total quantity sold, and profit margin.
-- Include only products with margin > 25%,
-- sort by margin descending.
SELECT 
    p.Name AS ProductName,
    SUM(sod.OrderQty) AS TotalSold,
    ((p.ListPrice - p.StandardCost) / p.ListPrice) * 100 AS ProfitMargin
FROM Production.Product p
INNER JOIN Sales.SalesOrderDetail sod 
    ON p.ProductID = sod.ProductID
WHERE p.ListPrice > 0   -- Avoid division by zero
GROUP BY p.Name, p.ListPrice, p.StandardCost
HAVING SUM(sod.OrderQty) > 100
   AND ((p.ListPrice - p.StandardCost) / p.ListPrice) * 100 > 25
ORDER BY ProfitMargin DESC;

-- Q6 (Author: Self)
-- For each month of 2011, show total quantity sold,
-- average list price, and total revenue for mountain bikes.
-- Only include products in the Mountain Bikes subcategory.
SELECT 
    YEAR(soh.OrderDate) AS Year,
    MONTH(soh.OrderDate) AS Month,
    SUM(sod.OrderQty) AS TotalQuantity,
    AVG(sod.UnitPrice) AS AvgListPrice,
    SUM(sod.LineTotal) AS TotalRevenue
FROM Production.Product p
INNER JOIN Production.ProductSubcategory ps 
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN Sales.SalesOrderDetail sod 
    ON p.ProductID = sod.ProductID
INNER JOIN Sales.SalesOrderHeader soh 
    ON sod.SalesOrderID = soh.SalesOrderID
WHERE ps.Name = 'Mountain Bikes'
  AND YEAR(soh.OrderDate) = 2011
GROUP BY YEAR(soh.OrderDate), MONTH(soh.OrderDate)
ORDER BY Month;

-- =====================================================
-- Metadata Questions (INFORMATION_SCHEMA)
-- =====================================================

-- Q7 (Author: Self)
-- List all tables in the Sales schema that contain a column
-- named "ProductID" or "CustomerID".
SELECT DISTINCT 
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'Sales'
  AND COLUMN_NAME IN ('ProductID', 'CustomerID')
ORDER BY TABLE_NAME;

-- Q8 (Author: Self)
-- Which views in the database reference the Product table?
-- Show the view name and all tables it references.
-- Fixed: Use correct column names from INFORMATION_SCHEMA.VIEW_TABLE_USAGE.
SELECT 
    v.VIEW_NAME AS ViewName,
    STRING_AGG(t.TABLE_NAME, ', ') WITHIN GROUP (ORDER BY t.TABLE_NAME) AS ReferencedTables
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE v
JOIN INFORMATION_SCHEMA.VIEW_TABLE_USAGE t 
    ON v.VIEW_NAME = t.VIEW_NAME
WHERE v.TABLE_NAME = 'Product'
GROUP BY v.VIEW_NAME
ORDER BY v.VIEW_NAME;