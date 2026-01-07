/*
=============================================================
Create Database
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouseAnalytics' after checking if it already exists. 
    If the database exists, it is dropped and recreated.
*/

USE master;
GO
-- Drop and recreate the 'DataWarehouseAnalytics' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouseAnalytics')
BEGIN
    ALTER DATABASE DataWarehouseAnalytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouseAnalytics;
END;

GO 
-- Create the 'DataWarehouseAnalytics' database
CREATE DATABASE DataWarehouseAnalytics;