/*
=============================================================
Create Tables
=============================================================
Script Purpose:
    This script creates new table named 'gold.dim_customers' 'gold.dim_product' 'gold.fact_sales' after checking if it already exists. 
    If the table exists, it is dropped and recreated.
*/

-- Checking and dropping the table if 'gold.dim_customers' exist
IF OBJECT_ID('gold.dim_customers','U') IS NOT NULL
	DROP TABLE gold.dim_customers;

GO
-- Creating 'gold.dim_customers' Table
CREATE TABLE gold.dim_customers(
	customer_key int,
	customer_id int,
	customer_number VARCHAR,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	country CHAR,
	marital_status CHAR,
	gender CHAR,
	birth_date DATE,
	create_date DATE
);

GO
-- Checking and dropping the table if 'gold.dim_product' exist
IF OBJECT_ID('gold.dim_product','U') IS NOT NULL
	DROP TABLE gold.dim_product;

GO
-- Creating 'gold.dim_product' Table
CREATE TABLE gold.dim_product(
	product_key int,
	product_id int,
	product_number VARCHAR,
	product_name VARCHAR,
	category_id VARCHAR,
	category VARCHAR,
	subcategory VARCHAR,
	maintenance CHAR,
	cost int,
	product_line VARCHAR,
	start_date DATE
);

GO
-- Checking and dropping the table if 'gold.fact_sales' exist
IF OBJECT_ID('gold.fact_sales','U') IS NOT NULL
	DROP TABLE gold.fact_sales;

GO
-- Creating 'gold.fact_sales' Table
CREATE TABLE gold.fact_sales(
	order_number VARCHAR,
	product_key int,
	customer_key int,
	order_date DATE,
	shipping_date DATE,
	due_date DATE,
	sales_amount int,
	quantity int,
	price int,
);