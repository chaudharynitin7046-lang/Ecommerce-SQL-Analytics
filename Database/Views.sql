USE Ecom

select * from customers
select * from orders
SELECT * FROM addresses
select * from products
select * from categories
select * from suppliers
SELECT * FROM order_items
SELECT * FROM reviews

-- View 1

CREATE VIEW CustomerOrderSummery AS
SELECT
	o.id AS OrderID,
	CONVERT(DATE, O.order_date) AS OrderDate,
	o.Customer_id,
	c.first_name +' ' + c.last_name AS CustomerName,
	c.email,
	o.status,
	o.total,
	a.city AS Shipping_City,
	a.state AS Shipping_State,
	a.country AS Shipping_Country
FROM orders o
JOIN customers c
ON o.customer_id = c.id
JOIN addresses a
ON o.shipping_address_id = a.id


--View 2

CREATE VIEW OrderDetails AS
SELECT
	o.id AS OrderID,
	p.id AS ProductID,
	p.name AS ProductName,
	ca.name AS Category,
	s.name AS SupplierName,
	oi.quantity,
	oi.unit_price,
	oi.discount,
	o.subtotal
FROM Orders o
JOIN Customers c
ON o.customer_id = c.id
JOIN order_items oi
ON o.id = oi.order_id
JOIN products p
ON oi.product_id = p.id
JOIN categories ca
ON p.category_id = ca.id
JOIN suppliers s
ON p.supplier_id = s.id


--View 3

CREATE VIEW ProductCatelog AS
SELECT 
	p.id,
	p.name AS ProductName,
	c.name AS Category,
	s.name AS Supplier,
	p.price,
	p.cost,
	p.stock_quantity AS Stock,
	CASE WHEN p.is_active = 1 THEN 'Yes'
	ELSE 'No'
	END AS Availability
FROM products p
JOIN categories c
ON p.category_id = c.id
JOIN suppliers s
ON p.supplier_id = s.id


--View 4

CREATE VIEW CustomerProfile AS
SELECT
	c.id AS CustomerID,
	c.first_name + ' ' + c.last_name AS FullName,
	c.email,
	c.phone,
	c.loyalty_tier,
	CASE WHEN c.is_active = 1 THEN 'YES' ELSE 'NO' END AS Active,
	COUNT(o.customer_id) AS TotalOrder,
	SUM(o.total) AS TotalSpending,
	CAST(AVG(o.total) AS DECIMAL(10,2)) AS AvgOrderValue
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
GROUP BY c.id,c.first_name + ' ' + c.last_name,c.email,c.phone,c.loyalty_tier,c.is_active


--View 5

CREATE VIEW ProductPerfomance AS
SELECT
	p.id AS ProductID,
	p.name AS ProductName,
	ca.name AS Category,
	SUM(oi.quantity) AS TotalUnitSold,
	SUM(oi.line_total) AS TotalRevenue,
	COUNT(DISTINCT oi.id) AS NumberOfOrder,
	AVG(r.rating) AS AvgRating
FROM products p
JOIN categories ca
ON p.category_id = ca.id
LEFT JOIN order_items oi
ON p.id = oi.product_id
LEFT JOIN reviews r
ON p.id = r.product_id
GROUP BY p.id,p.name,ca.name


SELECT *
FROM ProductPerfomance
WHERE ProductID = 1

SELECT SUM(line_total)
FROM order_items
WHERE product_id = 1


ALTER VIEW ProductPerfomance AS
WITH OrderSummary AS
(
    SELECT
        product_id,
        SUM(quantity) AS TotalUnitSold,
        SUM(line_total) AS TotalRevenue,
        COUNT(DISTINCT order_id) AS NumberOfOrder
    FROM order_items
    GROUP BY product_id
)
SELECT
    p.id AS ProductID,
    p.name AS ProductName,
    ca.name AS Category,
    os.TotalUnitSold,
    os.TotalRevenue,
    os.NumberOfOrder,
    AVG(r.rating) AS AvgRating
FROM products p
JOIN categories ca
ON p.category_id = ca.id
LEFT JOIN OrderSummary os
ON p.id = os.product_id
LEFT JOIN reviews r
ON p.id = r.product_id
GROUP BY p.id,p.name,ca.name,os.TotalUnitSold,os.TotalRevenue,os.NumberOfOrder


-- Prevent duplicate SUM() values caused by joining reviews.