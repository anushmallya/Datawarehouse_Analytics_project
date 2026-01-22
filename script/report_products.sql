/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/
IF OBJECT_ID('gold.product_report','V') IS NOT NULL
DROP VIEW gold.product_report;
GO

CREATE VIEW gold.product_report AS
WITH base_query AS
(SELECT 
    s.order_number,
    s.customer_key,
    s.order_date,
    s.sales_amount,
    s.quantity,
    p.product_key,
    p.product_name,
    p.category,
    p.subcategory,
    p.cost
FROM gold.fact_sales as s
LEFT JOIN gold.dim_product as p
    ON s.product_key = p.product_key
WHERE order_date IS NOT NULL)

,aggregation_of_products AS(
SELECT 
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS life_span,
    MAX(order_date) AS last_sale_date,
    SUM(sales_amount) AS total_sale,
    COUNT(DISTINCT order_number) AS total_order,
    SUM(quantity) AS total_products_sold,
    COUNT(DISTINCT customer_key) AS total_customers,
    ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)),1) AS avg_selling_price
FROM base_query
GROUP BY product_key,product_name,category,subcategory,cost)

SELECT 
    product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_sale_date,
	DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months,
	CASE
		WHEN total_sale > 50000 THEN 'High-Performer'
		WHEN total_sale >= 10000 THEN 'Mid-Range'
		ELSE 'Low-Performer'
	END AS product_segment,
	life_span,
	total_order,
	total_sale,
	total_products_sold,
	total_customers,
	avg_selling_price,
	CASE 
		WHEN total_order = 0 THEN 0
		ELSE total_sale / total_order
	END AS avg_order_revenue,
	CASE
		WHEN life_span = 0 THEN total_sale
		ELSE total_sale / life_span
	END AS avg_monthly_revenue
FROM aggregation_of_products