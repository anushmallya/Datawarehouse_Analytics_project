/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.
===============================================================================
*/
-- Explore all objects in the Database

SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Explore all columns in the Database

SELECT * FROM INFORMATION_SCHEMA.COLUMNS