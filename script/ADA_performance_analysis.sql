/*
===============================================================================
Performance Analysis
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.
===============================================================================
*/
-- Analyze the yearly performance of products by comparing each products sales to both its average sales performance and the previous year sale

SELECT
	order_year,
	product_name,
	total_sales,
	AVG(total_sales) OVER(PARTITION BY product_name) as average_sale,
	total_sales - AVG(total_sales) OVER(PARTITION BY product_name) AS average_difference,
	CASE 
		WHEN total_sales - AVG(total_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above Average'
		WHEN total_sales - AVG(total_sales) OVER(PARTITION BY product_name) < 0 THEN 'Below Average'
		ELSE 'Average'
	END AS status_avg,
	LAG(total_sales) OVER(PARTITION BY product_name ORDER BY order_year)  AS previous_year_sale,
	total_sales - LAG(total_sales) OVER(PARTITION BY product_name ORDER BY order_year) sale_difference,
	CASE 
		WHEN total_sales - LAG(total_sales) OVER(PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
		WHEN total_sales - LAG(total_sales) OVER(PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
		ELSE 'No Change'
	END AS status_sales
FROM
(SELECT 
	YEAR(order_date) AS order_year,
	product_name,
	SUM(sales_amount) AS total_sales
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_product AS p
	ON s.product_key = p.product_key
WHERE order_date IS NOT NULL
GROUP BY product_name, YEAR(order_date))t
ORDER BY product_name, order_year