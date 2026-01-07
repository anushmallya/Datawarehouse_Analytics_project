/*
=============================================================
Loading data into tables
=============================================================
Script Purpose:
    This script inserts data into tables named 'gold.dim_customers' 'gold.dim_product' 'gold.fact_sales' using bulk insert and storing it in a procedure.
	Executing the stored procedure.
*/

CREATE OR ALTER PROCEDURE gold.load_data_gold AS
BEGIN
	-- Truncating table and loading the data into 'gold.dim_customers' table
	TRUNCATE TABLE gold.dim_customers;
	BULK INSERT gold.dim_customers
	FROM 'C:\Users\Administrator\Desktop\Datawarehouse_Analytics_Project\dataset\gold.dim_customers.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	
	-- Truncating table and loading the data into 'gold.dim_product' table

	TRUNCATE TABLE gold.dim_product;
	BULK INSERT gold.dim_product
	FROM 'C:\Users\Administrator\Desktop\Datawarehouse_Analytics_Project\dataset\gold.dim_products.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	-- Truncating table and loading the data into 'gold.fact_sales' table

	TRUNCATE TABLE gold.fact_sales;
	BULK INSERT gold.fact_sales
	FROM 'C:\Users\Administrator\Desktop\Datawarehouse_Analytics_Project\dataset\gold.fact_sales.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
END

-- Executing the stored procedure
EXEC gold.load_data_gold