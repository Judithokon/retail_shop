-- Run once in a Databricks SQL editor after uploading the CSVs in setup/data
-- to the volume /Volumes/retail/raw/landing.

CREATE OR REPLACE TABLE retail.raw.customers AS
SELECT * FROM read_files('/Volumes/retail/raw/landing/customers.csv', format => 'csv', header => true, inferSchema => true);

CREATE OR REPLACE TABLE retail.raw.products AS
SELECT * FROM read_files('/Volumes/retail/raw/landing/products.csv', format => 'csv', header => true, inferSchema => true);

CREATE OR REPLACE TABLE retail.raw.orders AS
SELECT * FROM read_files('/Volumes/retail/raw/landing/orders.csv', format => 'csv', header => true, inferSchema => true);

CREATE OR REPLACE TABLE retail.raw.order_items AS
SELECT * FROM read_files('/Volumes/retail/raw/landing/order_items.csv', format => 'csv', header => true, inferSchema => true);

CREATE OR REPLACE TABLE retail.raw.payments AS
SELECT * FROM read_files('/Volumes/retail/raw/landing/payments.csv', format => 'csv', header => true, inferSchema => true);

