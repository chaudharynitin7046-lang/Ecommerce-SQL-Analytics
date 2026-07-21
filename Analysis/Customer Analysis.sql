USE Ecom

SELECT * FROM CustomerOrderSummery
SELECT * FROM CustomerProfile
SELECT * FROM customers
SELECT * FROM addresses
SELECT * FROM orders
SELECT * FROM OrderDetails
SELECT * FROM order_items

--Total Number Of CUstomer

SELECT COUNT(*) AS TotalCustomer
FROM customers

--Customer by City

SELECT
	city,
	COUNT(customer_id) AS TotalCustomer
FROM addresses
GROUP BY city,is_default
HAVING is_default = 1
ORDER BY TotalCustomer DESC

-- Customer By Country

SELECT
	country,
	COUNT(customer_id) AS TotalCustomer
FROM addresses
GROUP BY country,is_default
HAVING is_default = 1
ORDER BY TotalCustomer DESC

--Customer By State

SELECT
	state,
	COUNT(customer_id) AS TotalCustomer
FROM addresses
GROUP BY state,is_default
HAVING is_default = 1
ORDER BY TotalCustomer DESC

-- Males VS Females

SELECT
	gender,
	COUNT(*) AS Total
FROM customers
GROUP BY gender

-- ACTIVE VS INACTIVE

SELECT
	Active,
	COUNT(*) Total
FROM CustomerProfile
GROUP BY Active

-- Customer never placed any order

SELECT *
FROM CustomerProfile
WHERE TotalOrder = 0


-- Customer With More Than 5 Order

SELECT *
FROM CustomerProfile
WHERE TotalOrder > 5

-- Top 10 customer by number of order

SELECT TOP 10 *
FROM CustomerProfile
ORDER BY TotalOrder DESC

-- Avg order per customer

SELECT
	AVG(TotalOrder) AS AvgOrder
FROM CustomerProfile

--Top 10 customer by revenue

SELECT TOP 10 *
FROM CustomerProfile
ORDER BY TotalSpending DESC


--	Customer spending above avg spending

SELECT *
FROM CustomerProfile
WHERE TotalSpending > (
SELECT AVG(TotalSpending)
FROM CustomerProfile
)


-- Customer Life Time Value

SELECT
	CustomerID,
	FullName,
	email,
	phone,
	TotalSpending AS LifeTimeValue
FROM CustomerProfile
ORDER BY LifeTimeValue DESC

--customer avg order value

SELECT
	CustomerID,
	FullName,
	email,
	phone,
	TotalOrder,
	AvgOrderValue 
FROM CustomerProfile
ORDER BY AvgOrderValue DESC

-- Customers who generated more than 5% of total revenue

SELECT
	CustomerID,
	FullName,
	email,
	phone,
	TotalSpending
FROM CustomerProfile
WHERE TotalSpending >= (
SELECT SUM(TotalSpending) * 0.05
FROM CustomerProfile
)


--Customer added each month

SELECT
	YEAR(created_at) AS Year,
	MONTH(created_at) AS Month,
	COUNT(*) AS AddedCustomer
FROM customers
GROUP BY YEAR(created_at),MONTH(created_at)
ORDER BY YEAR(created_at),MONTH(created_at)

-- Customer who has not placed order in last 90 days

SELECT
    c.id,
    c.first_name + ' ' + c.last_name AS FullName
FROM customers c
WHERE NOT EXISTS
(
SELECT 1
FROM orders o
WHERE o.customer_id = c.id
AND o.order_date >= DATEADD(DAY, -90, GETDATE())
)

--Customer by age group
WITH CustomerAge AS
(
    SELECT
        id,
        date_of_birth,
        DATEDIFF(YEAR, date_of_birth, GETDATE()) AS Age
    FROM customers
)

SELECT
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS AgeGroup,

    COUNT(DISTINCT ca.id) AS NumberOfCustomers,
    COUNT(o.id) AS TotalOrders,
    SUM(o.total) AS TotalRevenue,
    SUM(o.total) / COUNT(DISTINCT ca.id) AS AvgSpendingPerCustomer

FROM CustomerAge ca
LEFT JOIN orders o
ON ca.id = o.customer_id

GROUP BY
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END


--Customer Purchase Frequency

SELECT
	CASE
		WHEN TotalOrder = 0 THEN 'Customer With NO Order'
	    WHEN TotalOrder = 1 THEN 'One Time Customer'
		WHEN TotalOrder BETWEEN 2 AND 5 THEN 'Ocasional Customer'
		WHEN TotalOrder BETWEEN 6 AND 10 THEN 'Regular Customer'
		WHEN TotalOrder > 10 THEN 'Loyal Customer'
	END AS Segment,
	COUNT(*) AS NumberOfCustomer
FROM CustomerProfile
GROUP BY CASE
			WHEN TotalOrder =0 THEN 'Customer With NO Order'
		    WHEN TotalOrder = 1 THEN 'One Time Customer'
			WHEN TotalOrder BETWEEN 2 AND 5 THEN 'Ocasional Customer'
			WHEN TotalOrder BETWEEN 6 AND 10 THEN 'Regular Customer'
			WHEN TotalOrder > 10 THEN 'Loyal Customer'
		END

--Customer Recency Order

WITH CustomerOrders AS
(
    SELECT
        customer_id,
        MAX(order_date) AS LastOrderDate
    FROM orders
    GROUP BY customer_id
)

SELECT
    CASE
        WHEN co.LastOrderDate IS NULL THEN 'Never ordered'
        WHEN DATEDIFF(DAY, co.LastOrderDate, GETDATE()) <= 30 THEN 'Last 30 days'
        WHEN DATEDIFF(DAY, co.LastOrderDate, GETDATE()) <= 90 THEN '31-90 days'
        WHEN DATEDIFF(DAY, co.LastOrderDate, GETDATE()) <= 180 THEN '91-180 days'
        ELSE 'More than 180 days'
    END AS CustomerGroup,

    COUNT(DISTINCT c.id) AS NumberOfCustomers,
    COUNT(DISTINCT c.id) * 100.0 / (SELECT COUNT(*) FROM customers) AS PercentageOfCustomers,
    ISNULL(SUM(o.total), 0) AS TotalRevenue

FROM customers c
LEFT JOIN CustomerOrders co
    ON c.id = co.customer_id
LEFT JOIN orders o
    ON c.id = o.customer_id

GROUP BY
    CASE
        WHEN co.LastOrderDate IS NULL THEN 'Never ordered'
        WHEN DATEDIFF(DAY, co.LastOrderDate, GETDATE()) <= 30 THEN 'Last 30 days'
        WHEN DATEDIFF(DAY, co.LastOrderDate, GETDATE()) <= 90 THEN '31-90 days'
        WHEN DATEDIFF(DAY, co.LastOrderDate, GETDATE()) <= 180 THEN '91-180 days'
        ELSE 'More than 180 days'
    END