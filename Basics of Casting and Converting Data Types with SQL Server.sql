-- For this exercise, we will use the AdventureWorks database provided by Microsoft
-- The three main tables that we will look at are in the Sales Database, and are Product Description, Product Category, and Product

SELECT *
FROM [SalesLT].[ProductDescription]

SELECT *
FROM [SalesLT].[ProductCategory]

SELECT *
FROM [SalesLT].[Product]

-- You can set up the AdventureWorksLT Database using the instructions in the description

-- The query below is an example of an inner join between two tables

SELECT ProductID,
Prod.Name,
Prod.ListPrice,
Prod.ProductCategoryID,
Cat.Name AS CatName
FROM SalesLT.Product Prod
INNER JOIN SalesLT.ProductCategory Cat 
ON Prod.ProductCategoryID = Cat.ProductCategoryID

SELECT * 
FROM information_schema.columns
WHERE TABLE_NAME = 'Product'

-- The default way to convert between data types in SQL Server is CAST
SELECT ProductID,
Prod.Name,
Prod.ListPrice,
Prod.ProductCategoryID,
CAST(Prod.ProductCategoryID AS VARCHAR) AS ProductCategoryIDSTR,
CASE WHEN Prod.ProductCategoryID = CAST(Prod.ProductCategoryID AS VARCHAR) 
THEN 'equal' 
ELSE 'not equal'
END AS equal_flag,
Cat.Name AS CatName
FROM SalesLT.Product Prod
INNER JOIN SalesLT.ProductCategory Cat 
ON Prod.ProductCategoryID = Cat.ProductCategoryID

-- An important consideration for cast is that some things only work for certain data types, in this case, we are concatenating a string and a number
SELECT ProductID,
Prod.Name,
Prod.ListPrice,
Prod.ProductCategoryID,
CONCAT(CAST(Prod.ProductCategoryID AS VARCHAR), 0) AS ProductCategoryIDSTR,
CAST(Prod.ProductCategoryID AS VARCHAR) AS ProductCategoryIDSTR,
CASE WHEN Prod.ProductCategoryID = CONCAT(CAST(Prod.ProductCategoryID AS VARCHAR), 0)
THEN 'equal' 
ELSE 'not equal'
END AS equal_flag,
Cat.Name AS CatName
FROM SalesLT.Product Prod
INNER JOIN SalesLT.ProductCategory Cat 
ON Prod.ProductCategoryID = Cat.ProductCategoryID

-- When looking at two strings, SQL Server will just put them together as a concatenation, instead of adding them if they were numbers

SELECT ProductID,
Prod.Name,
Prod.ListPrice,
Prod.ProductCategoryID,
CAST(Prod.ProductCategoryID AS VARCHAR) + CAST(3 AS VARCHAR) AS ProductCategoryIDSTR,
Cat.Name AS CatName
FROM SalesLT.Product Prod
INNER JOIN SalesLT.ProductCategory Cat 
ON Prod.ProductCategoryID = Cat.ProductCategoryID

-- Convert to numeric

SELECT ProductID,
Prod.Name,
Prod.ListPrice,
Prod.ProductCategoryID,
CAST(Prod.ProductCategoryID AS INT) + CAST(3 AS INT) AS ProductCategoryIDSTR,
Cat.Name AS CatName
FROM SalesLT.Product Prod
INNER JOIN SalesLT.ProductCategory Cat 
ON Prod.ProductCategoryID = Cat.ProductCategoryID

-- Notice how in this case, the result is different
SELECT ProductID,
Prod.Name,
Prod.ListPrice,
Prod.ProductCategoryID,
CAST(Prod.ProductCategoryID AS VARCHAR) AS ProductCategoryIDSTR,
Cat.Name AS CatName
FROM SalesLT.Product Prod
INNER JOIN SalesLT.ProductCategory Cat 
ON CAST(Prod.ProductCategoryID AS FLOAT) = CAST(Cat.ProductCategoryID AS BIT)

-- There are limitations to casting

SELECT ProductID,
Prod.Name,
Prod.ListPrice,
Prod.ProductCategoryID,
CAST(Prod.ProductCategoryID AS BIT) AS ProductCategoryIDSTR,
Cat.Name AS CatName
FROM SalesLT.Product Prod
INNER JOIN SalesLT.ProductCategory Cat 
ON CAST(Prod.ProductCategoryID AS FLOAT) = Cat.ProductCategoryID

-- The final advantage of casting is in using dates, convert is another option in SQL Server
-- SQL Server does a decent job in a lot of conversions, but not all databases do the same process

WITH dates AS (
SELECT '2024-02-01' AS string_col, 
CAST('2024-02-01' AS DATETIME) AS date_col,
CONVERT(DATE, '2024-02-01') AS conv_col
)
SELECT *,
CASE WHEN string_col >= CAST('2024-01-11' AS DATE) THEN 'correct'
ELSE 'incorrect'
END AS string_flag,
CASE WHEN date_col >= CAST('2024-01-11' AS DATE) THEN 'correct'
ELSE 'incorrect'
END AS date_flag,
CASE WHEN conv_col >= CAST('2024-01-11' AS DATE) THEN 'correct'
ELSE 'incorrect'
END AS conv_flag
FROM dates

-- Without conversion

WITH dates2 AS (
SELECT '2024-02-01' AS string_col, 
CAST('2024-02-01' AS DATETIME) AS date_col,
CONVERT(DATE, '2024-02-01') AS conv_col
)
SELECT *,
CASE WHEN string_col >= '2024-01-11' THEN 'correct'
ELSE 'incorrect'
END AS string_flag,
CASE WHEN date_col >= '2024-01-11' THEN 'correct'
ELSE 'incorrect'
END AS date_flag,
CASE WHEN conv_col >= '2024-01-11' THEN 'correct'
ELSE 'incorrect'
END AS conv_flag
FROM dates2
