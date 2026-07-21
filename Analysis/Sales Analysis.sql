USE Ecom

SELECT * FROM OrderDetails
SELECT * FROM order_items
SELECT * FROM orders
SELECT * FROM ProductPerfomance
SELECT * FROM OrderDetails
SELECT * FROM CustomerProfile
SELECT * FROM CustomerOrderSummery

--Total Revenue
SELECT SUM(total) AS TotalRevenue
FROM orders

--Total Number Of Order
SELECT COUNT(id) AS TotalOrder
FROM orders

-- Avrage Order Value
SELECT CAST(AVG(total) AS DECIMAL(10, 2)) AS AvgOrderValue
FROM orders

--HIGHEST ORDER VALUE
SELECT MAX(total) AS HighestOrder
FROM orders

--LOWEST ORDER VALUE
SELECT MIN(total) AS LowestOrder
FROM orders

--Monthly Revenue Trend
SELECT
	MONTH(order_date) AS Month,
	YEAR(order_date) AS Year,
	SUM(total) AS Revenueee
FROM orders
GROUP BY MONTH(order_date),YEAR(order_date)
ORDER BY Year,Month


--Monthly Order Trend
SELECT
	MONTH(order_date) AS Month,
	YEAR(order_date) AS Year,
	COUNT(id) AS Orderr
FROM orders
GROUP BY MONTH(order_date),YEAR(order_date)
ORDER BY Year,Month

--Month with Highest Revenue
SELECT
	TOP 1
	MONTH(order_date) AS Month,
	YEAR(order_date) AS Year,
	SUM(total) AS Revenueee
FROM orders
GROUP BY MONTH(order_date),YEAR(order_date)
ORDER BY Revenueee DESC,Year,Month


--Top 10 Product by Quantity Sold
SELECT TOP 10 *
FROM ProductPerfomance
ORDER BY TotalUnitSold DESC

--Top 10 Product by Revnue
SELECT TOP 10 *
FROM ProductPerfomance
ORDER BY TotalRevenue DESC

-- Top 5 Category by Revenue
SELECT
	TOP 5
	Category,
	SUM(TotalRevenue) AS Revenuee
FROM ProductPerfomance
GROUP BY Category
ORDER BY Revenuee DESC


-- TOP 5 Supplier by Revenue
SELECT
	TOP 5
	SupplierName,
	SUM(subtotal) AS Revenuee
FROM OrderDetails
GROUP BY SupplierName
ORDER BY Revenuee DESC

--avarage number of product per order

SELECT
	AVG(ProductPerOrder) AS AvgProduct
FROM (
SELECT
	COUNT(ProductID) AS ProductPerOrder
FROM OrderDetails
GROUP BY OrderID ) X

--MORE THAN OR 5 PRODUCTS ORDER
WITH TotalProduct AS(
SELECT
	OrderID,
	COUNT(ProductID) AS TotalProduct
FROM OrderDetails
GROUP BY OrderID
HAVING COUNT(ProductID) >= 5)
SELECT * FROM OrderDetails o
JOIN TotalProduct tp
ON o.OrderID = tp.OrderID


-- Avg discount per order

SELECT
	*,
	AVG(discount) OVER(PARTITION BY OrderID) AS DiscPerOrder
FROM OrderDetails

--Total Discount Given

SELECT
	SUM(discount) AS TotalDisc
FROM order_items

--TOP 10 CUSTOMER BY REVENUE

SELECT TOP 10 *
FROM CustomerProfile
ORDER BY TotalSpending DESC

-- CITY GENERATING HIGHEST REVENUE

SELECT
	TOP 1
	Shipping_City,
	SUM(total) AS Revenuee
FROM CustomerOrderSummery
GROUP BY Shipping_City
ORDER BY Revenuee DESC


--COUNTRY GENERATING HIGHEST REVENUE

SELECT
	TOP 1
	Shipping_Country,
	SUM(total) Revenuee
FROM CustomerOrderSummery
GROUP BY Shipping_Country
ORDER BY Revenuee DESC


-- revenue split by order status

SELECT
	status AS OrderStatus,
	SUM(total) AS Revenuee
FROM CustomerOrderSummery
GROUP BY status