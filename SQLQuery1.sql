-- Tao 1 database moi ten NewDtb
CREATE DATABASE NewDtb
GO
-- Taodatabase 
-- Thiet lap 2 thong so  PRIMARY va LOG
CREATE DATABASE NewDataB
ON PRIMARY
(NAME='NewDataB',FILENAME='C:\DATA\NewDataB.mdf',
SIZE=10MB, MAXSIZE=100MB, FILEGROWTH=1MB)
LOG ON (NAME='NewDataB_log',FILENAME='C:\DATA\NewDataB.ldf',
SIZE=10MB, MAXSIZE=unlimited, FILEGROWTH=1MB)
GO

--Thietlap 3  thong so PRIMARY, FILEGROUP, LOG
CREATE DATABASE NewDataB2
ON PRIMARY 
(NAME='NewDataB2',FILENAME='C:\DATA\NewDataB2.mdf',
SIZE=10MB,MAXSIZE=100MB,FILEGROWTH=1MB),
FILEGROUP myFileGroup
(NAME='NewDataB2_secondary',FILENAME='C:\DATA\NewDataB2.ndf',
SIZE=10MB,MAXSIZE=100MB,FILEGROWTH=1MB)
LOG ON (NAME='NewDataB2_log',FILENAME='C:\DATA\NewDataB2.ldf',
SIZE=10MB,MAXSIZE=unlimited,FILEGROWTH=1MB)
GO

--Sua doi ten database NewDataB-> NewDataB1
ALTER DATABASE NewDataB 
MODIFY NAME = NewDataB1
GO

--Chuyen so huu database
EXEC sp_changedbowner 'sa'
GO

--Chuyen sang database khac
USE NewDataB1
GO

--Xoa database
DROP DATABASE NewDtb
GO

--