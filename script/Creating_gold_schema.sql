/*
=============================================================
Create Schema
=============================================================
Script Purpose:
    This script creates a new Schema named 'gold' after checking if it already exists. 
    If the schema exists, it is dropped and recreated.
*/
-- Drop and recreating a gold schema in database if it already exists 

IF SCHEMA_ID('gold') IS NOT NULL
	DROP SCHEMA gold;
GO
CREATE SCHEMA gold;