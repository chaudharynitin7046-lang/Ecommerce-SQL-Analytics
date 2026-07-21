USE Ecom

--  INDEXING

CREATE INDEX IX_addresses_customer
ON addresses(customer_id);

CREATE INDEX IX_products_category
ON products(category_id);

CREATE INDEX IX_products_supplier
ON products(supplier_id);

CREATE INDEX IX_orders_customer
ON orders(customer_id);

CREATE INDEX IX_orders_shipping_address
ON orders(shipping_address_id);

CREATE INDEX IX_orders_billing_address
ON orders(billing_address_id);

CREATE INDEX IX_order_items_order
ON order_items(order_id);

CREATE INDEX IX_order_items_product
ON order_items(product_id);

CREATE INDEX IX_payments_order
ON payments(order_id);

CREATE INDEX IX_shipments_order
ON shipments(order_id);

CREATE INDEX IX_reviews_customer
ON reviews(customer_id);

CREATE INDEX IX_reviews_product
ON reviews(product_id);
