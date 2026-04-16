SET GLOBAL local_infile = 1;
CREATE DATABASE IF NOT EXISTS olist_db CHARACTER SET utf8mb4;
USE olist_db;

-- 1. Customers
CREATE TABLE IF NOT EXISTS customers (
    customer_id CHAR(32) PRIMARY KEY,
    customer_unique_id CHAR(32),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);

-- 2. Sellers
CREATE TABLE IF NOT EXISTS sellers (
    seller_id CHAR(32) PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);

-- 3. Products
CREATE TABLE IF NOT EXISTS products (
    product_id CHAR(32) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

-- 4. Orders (The central Hub)
CREATE TABLE IF NOT EXISTS orders (
    order_id CHAR(32) PRIMARY KEY,
    customer_id CHAR(32),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);

-- 5. Order Items (Note: Composite Primary Key)
CREATE TABLE IF NOT EXISTS order_items (
    order_id CHAR(32),
    order_item_id INT,
    product_id CHAR(32),
    seller_id CHAR(32),
    shipping_limit_date DATETIME,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2),
    PRIMARY KEY (order_id, order_item_id)
);

-- 6. Order Payments
CREATE TABLE IF NOT EXISTS order_payments (
    order_id CHAR(32),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL(10, 2)
);

-- 7. Order Reviews
CREATE TABLE IF NOT EXISTS order_reviews (
    review_id CHAR(32),
    order_id CHAR(32),
    review_score INT,
    review_comment_title VARCHAR(255),
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);

-- 8. Geolocation
CREATE TABLE IF NOT EXISTS geolocation (
    geolocation_zip_code_prefix VARCHAR(10),
    geolocation_lat DECIMAL(10, 8),
    geolocation_lng DECIMAL(11, 8),
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);

-- 9. Category Translation
CREATE TABLE IF NOT EXISTS product_category_translation (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);



-- Run these for each file. Replace 'C:/path/to/' with your actual local folder path.
-- We use OPTIONALLY ENCLOSED BY '"' because many strings in Olist contain commas.

LOAD DATA LOCAL INFILE "C:\Job Hunt\Projects\Datasets\Brazilian E-Commerce Public Dataset by Olist\olist_customers_dataset.csv" INTO TABLE customers 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:\Job Hunt\Projects\Datasets\Brazilian E-Commerce Public Dataset by Olist\olist_sellers_dataset.csv" INTO TABLE sellers 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:\Job Hunt\Projects\Datasets\Brazilian E-Commerce Public Dataset by Olist\olist_products_dataset.csv" INTO TABLE products 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:\Job Hunt\Projects\Datasets\Brazilian E-Commerce Public Dataset by Olist\olist_orders_dataset.csv" INTO TABLE orders 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:\Job Hunt\Projects\Datasets\Brazilian E-Commerce Public Dataset by Olist\olist_order_items_dataset.csv" INTO TABLE order_items 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:\Job Hunt\Projects\Datasets\Brazilian E-Commerce Public Dataset by Olist\olist_order_payments_dataset.csv" INTO TABLE order_payments 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:\Job Hunt\Projects\Datasets\Brazilian E-Commerce Public Dataset by Olist\olist_order_reviews_dataset.csv" INTO TABLE order_reviews 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:\Job Hunt\Projects\Datasets\Brazilian E-Commerce Public Dataset by Olist\olist_geolocation_dataset.csv" INTO TABLE geolocation 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:\Job Hunt\Projects\Datasets\Brazilian E-Commerce Public Dataset by Olist\product_category_name_translation.csv" INTO TABLE product_category_translation 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;


