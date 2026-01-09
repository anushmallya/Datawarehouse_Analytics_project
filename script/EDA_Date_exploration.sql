/*
===============================================================================
Data Exploration
===============================================================================
Purpose:
    - To explore the structure of the data
===============================================================================
*/
-- Find the date of the first and last order

SELECT 
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	DATEDIFF(YEAR,MIN(order_date),MAX(order_date)) AS order_rage_year
FROM gold.fact_sales