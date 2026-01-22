/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
===============================================================================
*/
-- Which catagories contribute the most to overall sales
SELECT
	category,
	total_sales,
	CONCAT(CAST(ROUND((CAST(total_sales AS decimal(10,2)) / CAST((SELECT SUM(sales_amount) FROM gold.fact_sales)AS decimal(10,2))) * 100,2) AS decimal(10,2)),'%') AS percentage
FROM
(SELECT 
	category,
	SUM(sales_amount) AS total_sales
FROM gold.fact_sales as s
LEFT JOIN gold.dim_product as p
	ON p.product_key = s.product_key
GROUP BY category)t
ORDER BY total_sales DESC