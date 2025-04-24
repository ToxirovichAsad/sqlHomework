
--TASK1

DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += '
USE [' + name + '];
SELECT 
    DB_NAME() AS database_name,
    s.name AS schema_name,
    t.name AS table_name,
    c.name AS column_name,
    ty.name AS data_type
FROM 
    sys.tables t
    INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
    INNER JOIN sys.columns c ON t.object_id = c.object_id
    INNER JOIN sys.types ty ON c.user_type_id = ty.user_type_id;
'
FROM sys.databases
WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')
  AND state_desc = 'ONLINE';

EXEC sp_executesql @sql;


--TAsk2

USE lesson10;
GO

CREATE OR ALTER PROCEDURE usp_GetProcFuncAndParams
    @DatabaseName SYSNAME = NULL  -- Optional database name
AS
BEGIN
    SET NOCOUNT ON;

    -- Temp table to store results
    IF OBJECT_ID('tempdb..##ProcFuncParams') IS NOT NULL
        DROP TABLE ##ProcFuncParams;

    CREATE TABLE ##ProcFuncParams (
        database_name SYSNAME,
        schema_name SYSNAME,
        object_name SYSNAME,
        object_type NVARCHAR(60),
        parameter_name SYSNAME,
        data_type SYSNAME,
        max_length INT
    );

    DECLARE @DynamicSQL NVARCHAR(MAX), @dbName SYSNAME;

    -- Cursor to loop through databases
    DECLARE db_cursor CURSOR FOR
    SELECT name
    FROM sys.databases
    WHERE state_desc = 'ONLINE'
      AND name NOT IN ('master', 'tempdb', 'model', 'msdb')
      AND (@DatabaseName IS NULL OR name = @DatabaseName);

    OPEN db_cursor;
    FETCH NEXT FROM db_cursor INTO @dbName;

    -- Loop through each database
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Dynamic SQL to query each database
        SET @DynamicSQL = '
        USE [' + QUOTENAME(@dbName) + '];

        INSERT INTO tempdb..##ProcFuncParams
        SELECT 
            ''' + @dbName + ''' AS database_name,
            r.ROUTINE_SCHEMA AS schema_name,
            r.ROUTINE_NAME AS object_name,
            r.ROUTINE_TYPE AS object_type,
            p.PARAMETER_NAME AS parameter_name,
            p.DATA_TYPE AS data_type,
            p.CHARACTER_MAXIMUM_LENGTH AS max_length
        FROM 
            INFORMATION_SCHEMA.ROUTINES r
        LEFT JOIN 
            INFORMATION_SCHEMA.PARAMETERS p 
            ON r.ROUTINE_NAME = p.ROUTINE_NAME 
            AND r.ROUTINE_SCHEMA = p.SPECIFIC_SCHEMA
        WHERE 
            r.ROUTINE_CATALOG = ''' + @dbName + ''' 
            AND (r.ROUTINE_TYPE = ''PROCEDURE'' OR r.ROUTINE_TYPE = ''FUNCTION'');
        ';

        BEGIN TRY
            -- Execute dynamic SQL to retrieve data for the current database
            EXEC sp_executesql @DynamicSQL;
        END TRY
        BEGIN CATCH
            PRINT 'Error in database [' + @dbName + ']: ' + ERROR_MESSAGE();
        END CATCH;

        -- Fetch the next database
        FETCH NEXT FROM db_cursor INTO @dbName;
    END

    CLOSE db_cursor;
    DEALLOCATE db_cursor;

    -- Return the results from the temp table
    SELECT * FROM ##ProcFuncParams
    ORDER BY database_name, schema_name, object_name, parameter_name;
END;
GO


EXEC usp_GetProcFuncAndParams;

