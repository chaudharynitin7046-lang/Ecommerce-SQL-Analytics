USE Ecom

SELECT * FROM ProductPerfomance
SELECT * FROM ProductCatelog
SELECT * FROM products
SELECT * FROM categories

-- Total Product

SELECT COUNT(*) AS TotalProduct
FROM products


-- AVCTIVE VS INACTIVE PRODUCT

SELECT
	Availability,
	COUNT(*) AS TotalProduct
FROM ProductCatelog
GROUP BY Availability


--Product by Category

SELECT
	Category,
	COUNT(*) AS TotalProduct
FROM ProductCatelog
GROUP BY Category

-- Product by Suppiler

SELECT
	Supplier,
	COUNT(*) AS TotalProduct
FROM ProductCatelog
GROUP BY Supplier

-- Product Never Sold

SELECT
	ProductID,
	ProductName,
	Category,
	TotalUnitSold
FROM ProductPerfomance
WHERE TotalUnitSold IS NULL


-- TOP 10 PRODUCT BY REVENUE

SELECT TOP 10 *
FROM ProductPerfomance
ORDER BY TotalRevenue DESC

-- TOP 10 ORDERED PRODUCT

SELECT TOP 10 *
FROM ProductPerfomance
ORDER BY NumberOfOrder DESC


--LOWEST SELLING PRODUCT

SELECT TOP 5 *
FROM ProductPerfomance
ORDER BY NumberOfOrder


-- HIGHEST RATED PRODUCT

SELECT *
FROM ProductPerfomance
WHERE AvgRating = (
SELECT MAX(AvgRating) 
FROM ProductPerfomance
)


-- LOWEST RATED PRODUCT

SELECT *
FROM ProductPerfomance
WHERE AvgRating = (
SELECT MIN(AvgRating) 
FROM ProductPerfomance
)

--PRODUCT WITH 0 REVIEW

SELECT *
FROM ProductPerfomance
WHERE AvgRating IS NULL

--AVG PRODUCT PRICE BY CATEGORY

SELECT
	Category,
	CAST(AVG(price) AS DECIMAL(10,2)) AS AvgPrice
FROM ProductCatelog
GROUP BY Category



--AVG RATING BY CATEGORY

SELECT
	Category,
	AVG(AvgRating) AS AvgRating
FROM ProductPerfomance
GROUP BY Category


-- SUPPLIER PERFOMANCE

SELECT
	pc.supplier,
	COUNT(pc.id) AS TotalProduct,
	SUM(pp.TotalRevenue) AS TotalRevenue,
	AVG(pp.AvgRating) AS AvgRating
FROM ProductCatelog pc
JOIN ProductPerfomance pp
ON pc.id = pp.ProductID
GROUP BY pc.Supplier


--CATEGORY CONTRIBUTING MOST IN REVENUE

SELECT
	Category,
	SUM(TotalRevenue) AS TotalRevenue,
	SUM(TotalRevenue) * 100.0 / SUM(SUM(TotalRevenue)) OVER () AS RevenuePercent
FROM ProductPerfomance
GROUP BY Category

--PRODUCT ABOVE AVG TOTAL REVENUE

SELECT *
FROM ProductPerfomance
WHERE TotalRevenue > (
SELECT AVG(TotalRevenue)
FROM ProductPerfomance
)


--PRODUCT WITH BELOW AVG RATING BUT HIGHER THAN AVG REVENUE

SELECT *
FROM ProductPerfomance
WHERE AvgRating < (
SELECT AVG(AvgRating)
FROM ProductPerfomance
)
AND TotalRevenue > (
SELECT AVG(TotalRevenue)
FROM ProductPerfomance
)

-- TOP PRODUCT IN EACH CATEGORY

SELECT * 
FROM (
SELECT *,
	DENSE_RANK() OVER(PARTITION BY Category ORDER BY TotalRevenue DESC) AS rnk
FROM ProductPerfomance) X
WHERE rnk = 1

--ABC ANALYSIS
SELECT
	ProductID,
	ProductName,
	Category,
	CASE
	WHEN CumulativeRevenue * 100 / Revenue <= 80 THEN 'A'
	WHEN CumulativeRevenue * 100 / Revenue <= 95 THEN 'B'
	ELSE 'C'
	END AS Abc_Class
FROM
(SELECT *,
	SUM(TotalRevenue) OVER(ORDER BY TotalRevenue DESC) AS CumulativeRevenue,
	SUM(TotalRevenue) OVER() AS Revenue
FROM ProductPerfomance) x
ORDER BY Revenue DESC