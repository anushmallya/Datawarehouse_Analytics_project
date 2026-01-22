/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis. 
===============================================================================
*/
-- Segment products into cost ranges and count how many products fall into each segments
SELECT 
	cost_range,
	COUNT(product_key) AS total_products
FROM
(SELECT
	product_key,
	product_name,
	cost,
	CASE
		WHEN cost >= 100 AND cost < 500 THEN 'Between 100 - 500'
		WHEN cost >= 500 AND cost < 1000 THEN 'Between 500 - 1000'
		WHEN cost >= 1000 AND cost < 1500 THEN 'Between 1000 - 1500'
		WHEN cost >= 1500 AND cost < 2000 THEN 'Between 1500 - 2000'
		WHEN cost >= 2000 THEN '2000 and above' 
		ELSE 'Below 100'
	END AS cost_range
FROM gold.dim_product)t
GROUP BY cost_range
ORDER BY total_products DESC

-- Group customers into three sengments based on their spending begaviour:
-- VIP: at least 12 months of history and spending more than 5000.
-- Regular: at least 12 months of history but spending 5000 or less
-- New: lifesapn less than 12 months
-- Find the total number of customers by each group

SELECT
	CASE
		WHEN total_amount_spend > 5000 AND histroy_travel >=12 THEN 'VIP'
		WHEN total_amount_spend <= 5000 AND histroy_travel >=12 THEN 'Regular'
		ELSE 'New'
	END AS tag,
	COUNT(DISTINCT customer_id) as total_customer
FROM
(SELECT 
	customer_id,
	first_name,
	last_name,
	SUM(sales_amount) as total_amount_spend,
	MIN(order_date) as first_order,
	MAX(order_date) as last_order,
	DATEDIFF(mm,MIN(order_date),MAX(order_date)) as histroy_travel
FROM gold.dim_customers as c
LEFT JOIN gold.fact_sales as s
	ON c.customer_key = s.customer_key
GROUP BY customer_id,first_name,last_name)t
GROUP BY CASE
		WHEN total_amount_spend > 5000 AND histroy_travel >=12 THEN 'VIP'
		WHEN total_amount_spend <= 5000 AND histroy_travel >=12 THEN 'Regular'
		ELSE 'New'
	END
ORDER BY total_customer
