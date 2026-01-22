/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/

IF OBJECT_ID('gold.customer_report','V') IS NOT NULL
DROP VIEW gold.customer_report;
GO

CREATE VIEW gold.customer_report AS
WITH base_query AS(
SELECT 
	order_number,
	order_date,
	product_key,
	sales_amount,
	quantity,
	customer_number,
	CONCAT(first_name,' ',last_name) AS customer_name,
	DATEDIFF(year,GETDATE(),birth_date)*-1 AS age
FROM gold.fact_sales as s
LEFT JOIN gold.dim_customers as c
	ON s.customer_key = c.customer_key
WHERE order_date IS NOT NULL)

,aggregation_of_customer AS(
SELECT 
	customer_number,
	customer_name,
	age,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	COUNT(DISTINCT product_key) AS total_products,
	MAX(order_date) AS last_order_date,
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS life_sapn
FROM base_query
GROUP BY customer_number,customer_name,age)

SELECT 
	customer_number,
	customer_name,
	age,
	CASE 
	 WHEN age < 20 THEN 'Under 20'
	 WHEN age between 20 and 29 THEN '20-29'
	 WHEN age between 30 and 39 THEN '30-39'
	 WHEN age between 40 and 49 THEN '40-49'
	 ELSE '50 and above'
    END AS age_group,
	CASE
		WHEN total_sales > 5000 AND life_sapn >=12 THEN 'VIP'
		WHEN total_sales <= 5000 AND life_sapn >=12 THEN 'Regular'
		ELSE 'New'
	END AS tag,
	total_orders,
	total_sales,
	total_quantity,
	total_products,
	last_order_date,
	DATEDIFF(MONTH,last_order_date,GETDATE()) AS recency,
	CASE 
		WHEN total_sales = 0 THEN 0
		ELSE total_sales/total_orders
	END AS average_order_value,
	life_sapn,
	CASE 
		WHEN total_sales = 0 OR life_sapn = 0 THEN total_sales
		ELSE total_sales/life_sapn
	END AS average_monthly_sale
FROM aggregation_of_customer