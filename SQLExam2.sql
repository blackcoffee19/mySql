USE master
--R1 Create database with Primary File Group
CREATE DATABASE Exam2
ON PRIMARY 
(NAME='Exam2',FILENAME='C:\DATA\Exam2.mdf',
SIZE=2MB,MAXSIZE=unlimited,FILEGROWTH=1MB),
FILEGROUP exam2
(NAME='exam2_secondary',FILENAME='C:\DATA\exam2.ndf',
SIZE=2MB,MAXSIZE=unlimited,FILEGROWTH=1MB)
LOG ON (NAME='exam2_log',FILENAME='C:\DATA\exam2.ldf',
SIZE=2MB,MAXSIZE=unlimited,FILEGROWTH=1MB)
GO
USE Exam2
CREATE TABLE TVType (
	TypeCode VARCHAR(10) PRIMARY KEY NONCLUSTERED,
	TypeName VARCHAR(10),
	Description VARCHAR(50)
)
GO
DROP TABLE TVType
CREATE TABLE Television (
	TVCode VARCHAR(10) PRIMARY KEY NONCLUSTERED,
	Manufacture VARCHAR(30),
	Price INT,
	Size INT, 
	TypeCode VARCHAR(10)
)
GO
--R3
ALTER TABLE Television
ADD CONSTRAINT Price CHECK (Price BETWEEN 51 AND 4999)
GO
--R4
ALTER TABLE Television
ADD DEFAULT 'unknow' FOR Manufacture
GO

--R5
CREATE CLUSTERED INDEX IX_Type ON TVType(TypeName)
GO
--R6

ADD CONSTRAINT TVCode FOREIGN KEY REFERENCES TVType(TypeCode)
GO
INSERT INTO TVType VALUES('SM01','Samsung','cheapest'),
						('LG01','LG',''),
						('SM02','Samsung2','Expensive'),
						('TO01','Toshiba',''),
						('AP01','APPLE','Expensive')
GO
INSERT INTO Television VALUES('TV01','Smart tivi',2000,2,'SM02'),
								('TV02','tivi',3000,3,'LG01'),
								('TV03','tivi',1000,4,'SM01'),
								('TV04','Smart tivi',2500,2,'TO01'),
								('TV05','Smart tivi',4500,1,'AP01')
GO

--R7
CREATE VIEW TVInfo 
AS 
	SELECT TVCode,Manufacture,Price,Size,TE.TypeCode,T.TypeName,T.Description
	FROM Television TE INNER JOIN TVType T ON TE.TypeCode=T.TypeCode
	WHERE Price<100
GO
INSERT INTO Television VALUES('TV06','Small TV',70,6,'SM01')
SELECT * FROM TVInfo

CREATE PROC ShowTV @size INT
