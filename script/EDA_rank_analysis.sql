/*
===============================================================================
Rank Analysis
===============================================================================
Purpose:
	-- To Rank the items based on the performance in sales and dimensions
===============================================================================
*/

-- Which 5 products generate the highest revenue

SELECT TOP 5
	product_name,
	SUM(sales_amount) AS total_revenue
FROM gold.fact_sales as s
LEFT JOIN gold.dim_product as p
	ON p.product_key = s.product_key
GROUP BY product_name
ORDER BY total_revenue DESC

-- What are the 5 products that are performing worst in terms of sales

SELECT TOP 5
	product_name,
	SUM(sales_amount) AS total_revenue
FROM gold.fact_sales as s
LEFT JOIN gold.dim_product as p
	ON p.product_key = s.product_key
GROUP BY product_name
ORDER BY total_revenue ASC

-- Find the top 10 customers who have generated the highest revenue

SELECT TOP 10
	c.customer_id,
	c.first_name,
	c.last_name,
	SUM(sales_amount) AS total_revenue
FROM gold.fact_sales as s
LEFT JOIN gold.dim_customers as c
	ON c.customer_key = s.customer_key
GROUP BY 
	c.customer_id,
	c.first_name,
	c.last_name
ORDER BY total_revenue DESC

-- Find the 3 customers who have ordered less

SELECT TOP 3
	c.customer_id,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT order_number) AS total_order
FROM gold.fact_sales as s
LEFT JOIN gold.dim_customers as c
	ON c.customer_key = s.customer_key
GROUP BY 
	c.customer_id,
	c.first_name,
	c.last_name
ORDER BY total_order


