IF EXISTS (SELECT DB_ID('AlottaVLFs'))
DROP DATABASE [AlottaVLFs]
GO
CREATE DATABASE [AlottaVLFs]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AlottaVLFs', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQL2K16\MSSQL\DATA\AlottaVLFs.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AlottaVLFs_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQL2K16\MSSQL\DATA\AlottaVLFs_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO

DECLARE @FileSizeKB INT = 73728
WHILE @FileSizeKB < (17000*1024) -- 8000MB to KB
BEGIN
SET @FileSizeKB = @FileSizeKB + 65536 --Grow the file by just 64MB at a time.
--SET @FileSizeKB = @FileSizeKB + 1024 --Grow the file by just 1MB at a time.
EXEC ('ALTER DATABASE [AlottaVLFs] MODIFY FILE ( NAME = N''AlottaVLFs_log'', SIZE = '+@FileSizeKB+'KB )')
PRINT @FileSizeKB/1024.
END
GO
--16008.000000MB

/*

	  USE [AlottaVLFs]
	DBCC SHRINKFILE (N'AlottaVLFs_log' , 0, TRUNCATEONLY)
	GO
	USE [master]
	ALTER DATABASE [AlottaVLFs] MODIFY FILE ( NAME = N'AlottaVLFs_log', SIZE = 8000MB )  
	GO
	ALTER DATABASE [AlottaVLFs] MODIFY FILE ( NAME = N'AlottaVLFs_log', SIZE = 16192MB )
	GO
	ALTER DATABASE [AlottaVLFs] MODIFY FILE ( NAME = N'AlottaVLFs_log', SIZE = 17000MB )
	GO
	

*/