-- Connect to Vostro MSSQL
--- From bash
-- sqlcmd -S 192.168.0.191,1433 -U SA -P

--- From VSCode
-- MS SQL:Connect

-- Copy file to SQL machine (Run in bash)
-- scp /home/agar2/Documents/WFP/crop_total2.csv vostro@192.168.0.191:/home/vostro/Documents/WFP/crop_total2.csv

-- List databases
SELECT Name from sys.databases

-- Create login account
CREATE LOGIN vostro WITH PASSWORD = 'C0ffeemilk';

-- Add login account to executive role
ALTER ROLE serveradmin ADD MEMBER ['vostro']; 
GO


-- Create a new database called 'WFP'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'WFP'
)
CREATE DATABASE WFP
GO

-- STAGING TABLE --

DROP TABLE [dbo].[crop_total_staging2]
USE WFP;
CREATE TABLE dbo.crop_total_staging2
(
--    ID INT NOT NULL PRIMARY KEY IDENTITY,
    area CHAR(255) NOT NULL,
    item CHAR(255) NOT NULL,
    element CHAR(255) NOT NULL,
    year INT,
    unit CHAR (255) NOT NULL,
    value FLOAT
);
GO
BULK INSERT crop_total_staging2
    FROM '/home/vostro/Documents/WFP/FAO Data/crop_data.csv'
    WITH
    (
        FIRSTROW = 2,
        FIELDTERMINATOR = '|',  --CSV field delimiter
        ROWTERMINATOR = '0x0A',
        FIELDQUOTE = '"',
        FORMAT = 'CSV',
        TABLOCK
    --    KEEPIDENTITY
    );

SELECT COUNT(*) FROM dbo.crop_total_staging2;
SELECT TOP (20) * FROM dbo.crop_total_staging2;
SELECT DISTINCT(area) FROM dbo.crop_total_staging2;

CREATE VIEW countries 
AS 
SELECT COUNT(area)
FROM dbo.crop_total_staging2 
GROUP BY area;
---------------------------------------------SECTION

-- Show table structure info --
sp_help crop_total;
sp_help crop_total_staging;
sp_help livestock_staging;
exec sp_columns crop_total_staging;

SELECT COUNT(*) FROM crop_total_staging;

SELECT * FROM sys.database_role_members;

SELECT SP.name,
SP.principal_id,
SP.sid,
SP.type,
SP.type_desc,
SP.is_disabled,
SP.create_date,
SP.modify_date,
SP.default_database_name,
SP.default_language_name,
SP.credential_id,
SP.owning_principal_id,
SP.is_fixed_role
FROM sys.server_principals AS SP;
---------------------------------------------SECTION
SELECT TOP 10 CONVERT(INT, year) from dbo.crop_total_staging;
SELECT TOP 10 year from dbo.crop_total_staging;
SELECT TOP 10 CAST([year] AS INT) from dbo.crop_total_staging;


select 
  case 
      when isnumeric(year) = 1 then 
              cast(year AS int)
      else
              NULL
 end

AS 'my_NvarcharColumnmitter'
from crop_total_staging;
