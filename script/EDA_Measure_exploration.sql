/*
===============================================================================
Measure Exploration
===============================================================================
Purpose:
    - To explore and calculate aggregated metrics for insights.
    - To create a report that show the key metrics of business 
===============================================================================
*/
-- Find the total sales
-- Find how many items are sold
-- Find the average selling price
-- Find the total number of orders
-- Find the total number of customers
-- Find the total number of products
-- Find the total number of customers that has placed an order

SELECT 
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_items_sold,
	AVG(price) AS average_price,
	COUNT(DISTINCT order_number) AS total_orders,
	COUNT(DISTINCT customer_key) AS total_customers,
	(SELECT DISTINCT COUNT(product_name) AS total_products FROM gold.dim_product) AS total_products,
	(SELECT COUNT(DISTINCT customer_id) total_customer_placed_order
	 FROM gold.dim_customers
	 WHERE customer_id IN (SELECT customer_key FROM gold.fact_sales)) AS total_customer_placed_order
FROM gold.fact_sales 

-- Report that shows all key metrics of the business

SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Items Sold',SUM(quantity)FROM gold.fact_sales
UNION ALL
SELECT 'Average Selling Price',AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders',COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Customers',COUNT(DISTINCT customer_key) FROM gold.fact_sales
UNION ALL
SELECT DISTINCT 'Total Products',COUNT(product_name) FROM gold.dim_product
UNION ALL
SELECT 'Total Customers Placed Order',COUNT(DISTINCT customer_id)
FROM gold.dim_customers
WHERE customer_id IN (SELECT customer_key FROM gold.fact_sales)


