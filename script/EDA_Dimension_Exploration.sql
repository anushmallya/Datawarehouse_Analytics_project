/*
===============================================================================
Dimension Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension table
===============================================================================
*/
-- Exploring the dimentions in the table 'gold.dim_customers'
SELECT * FROM gold.dim_customers

-- The dimentions to be explored are customer_id,customer_number,country,marital_status,gender

-- Explore all countries in 'gold.dim_customers' table
 
SELECT DISTINCT country FROM gold.dim_customers

-- Explore all catagories in 'gold.dim_product' table "The major division"

SELECT DISTINCT category,subcategory,product_name FROM gold.dim_product
ORDER BY 1,2,3