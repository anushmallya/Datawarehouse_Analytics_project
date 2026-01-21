/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
	- To track trends, growth, and changes in key metrics over time.
    - To measure growth or decline over specific periods.
===============================================================================
*/
-- Analyse sales performance over time
SELECT *
FROM (
	SELECT
		YEAR(order_date) AS year,
		MONTH(order_date) AS month,
		SUM(sales_amount) AS total_sales,
		COUNT(DISTINCT customer_key) AS total_customers,
		SUM(quantity) AS total_quantity
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY
		YEAR(order_date),
		MONTH(order_date)
) t
ORDER BY year, month;
