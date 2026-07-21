USE Ecom


--FOREIGN KEYS

ALTER TABLE addresses
ADD CONSTRAINT FK_addresses_customers
FOREIGN KEY (customer_id)
REFERENCES customers(id);

ALTER TABLE products
ADD CONSTRAINT FK_products_categories
FOREIGN KEY (category_id)
REFERENCES categories(id);

ALTER TABLE products
ADD CONSTRAINT FK_products_suppliers
FOREIGN KEY (supplier_id)
REFERENCES suppliers(id);

ALTER TABLE orders
ADD CONSTRAINT FK_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(id);

ALTER TABLE orders
ADD CONSTRAINT FK_orders_addresses
FOREIGN KEY (shipping_address_id)
REFERENCES addresses(id);


ALTER TABLE orders
ADD CONSTRAINT FK_billing_orders_addresses
FOREIGN KEY (billing_address_id)
REFERENCES addresses(id);


ALTER TABLE order_items
ADD CONSTRAINT FK_order_items_orders
FOREIGN KEY (order_id)
REFERENCES orders(id);

ALTER TABLE order_items
ADD CONSTRAINT FK_order_items_products
FOREIGN KEY (product_id)
REFERENCES products(id);

ALTER TABLE payments
ADD CONSTRAINT FK_payments_orders
FOREIGN KEY (order_id)
REFERENCES orders(id);

ALTER TABLE shipments
ADD CONSTRAINT FK_shipments_orders
FOREIGN KEY (order_id)
REFERENCES orders(id);

ALTER TABLE reviews
ADD CONSTRAINT FK_reviews_customers
FOREIGN KEY (customer_id)
REFERENCES customers(id);

ALTER TABLE reviews
ADD CONSTRAINT FK_reviews_products
FOREIGN KEY (product_id)
REFERENCES products(id);


