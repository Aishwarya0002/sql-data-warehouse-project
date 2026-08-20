/* 
=========================================================================================
Stored Procedure: Load Bronze Layer (Source -> bronze)
=========================================================================================
Script Purpose: 
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the following actions:
  - Truncates the bronze tables before loading data.
  - Uses the 'BULK INSERT' command to load data from CSV files to bronze tables.

Parameters:
  None.
  This stored procedure does not accept any parameters or return any values.

Usage Example:
EXEC bronze.load_bronze;
=========================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME,
    @batch_end_time DATETIME;
    BEGIN TRY 
        SET @batch_start_time = GETDATE();
        PRINT '===========================================';
        PRINT 'Loading Bronze Layer';
        PRINT '===========================================';

        PRINT '===========================================';
        PRINT 'Loading CRM Tables';
        PRINT '===========================================';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;
        PRINT '>> Inserting Data Info: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM '/tmp/cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '============================================'
        PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration:  ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time)
        AS NVARCHAR) + ' seconds';
        PRINT '============================================='
    END TRY
    BEGIN CATCH 
        PRINT '==============================================='
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
        PRINT 'Error Message' + ERROR_MESSAGE();
        PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '=========================================='
    END CATCH
END
