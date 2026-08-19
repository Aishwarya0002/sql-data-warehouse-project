/* 
==================================================================
Create Databases & schemas 
==================================================================
Script purpose:
  This script creates a new database called 'DataWarehouse' after checking if it already exists. 
  If the database exists, it is dropped & recreated. Additionally, three schemas are set up within the database, 
  namely- 'bronze', 'silver', 'gold'. 

WARNING:
  Running this script will drop the entire database 'DataWarehouse' if it exists. All the data in the database will be 
  permanently deleted. Proceed with caution and ensure you have proper backups before running this script. 
*/

USE master;
GO

-- drop & recreate 'DataWarehouse' database

IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
  ALTER DATABASE 'DataWarehouse' SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE 'DataWarehouse';
END;
GO

-- create 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- creating different schemas 
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
