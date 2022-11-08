CREATE DATABASE Ass5_db
ON PRIMARY
(NAME='Ass5_db',FILENAME='C:\DATA\Ass5.mdf',
SIZE=5MB, MAXSIZE=5MB, FILEGROWTH=10%)
LOG ON (NAME='Ass5_log',FILENAME='C:\DATA\Ass5_lg.ldf',
SIZE=2MB, MAXSIZE=2MB, FILEGROWTH=10%)
GO
USE Ass5_db 
GO
CREATE TABLE tbCustomer (
	CUSTID varchar(20) PRIMARY KEY,
	FullName varchar(40),
	Address varchar(60),
	Phone INT
)
GO
CREATE TABLE tbCategory (
	CATID varchar(2) PRIMARY KEY,
	CatName varchar(40)
)
GO
CREATE TABLE tbProduct(
	PROID  varchar(10) PRIMARY KEY,
	ProName varchar(40),
	UnitPrice FLOAT CHECK (UnitPrice BETWEEN 1 AND 200),
	Unit varchar(20),
	CATID varchar(2),
	FOREIGN KEY(CATID) REFERENCES tbCategory(CATID)
)
GO
CREATE TABLE tbOrder(
	ORDERID INT IDENTITY(300,1) PRIMARY KEY,
	OrderDate DATE DEFAULT getdate(),
	Comment varchar(60) DEFAULT 'Nothing',
	CUSTID varchar(20) FOREIGN KEY REFERENCES tbCustomer(CUSTID) 
)
GO
CREATE TABLE tbOrderDetail (
	ORDERID INT FOREIGN KEY REFERENCES tbOrder(ORDERID),
	PROID varchar(10) FOREIGN KEY REFERENCES tbProduct(PROID),
	Quantity INT DEFAULT 1,
	PRIMARY KEY (ORDERID,PROID)
)
GO

--3
INSERT INTO tbCustomer VALUES('C01','Lyly Tran','No Trang Long',113),
('C02','Alex Pham','Nguyen Trai',911),
('C03','Rose Nguyen','Pham Ngu Lao',1080),
('C04','Alan Pham','Nguyen Tri Phuong',118)
GO
INSERT INTO tbCategory VALUES('FO','Food'),('BE','Beveage'),('OT','Other')
GO
INSERT INTO tbProduct VALUES('P01','Coca Cola',2.5,'can','BE'),
('P02','Beer 333',4,'can','BE'),
('P03','Chocolate',9,'pack','FO'),
('P04','Chocopie Cake',4,'pack','FO'),
('P05','Cheese',10,'pack','FO'),
('P06','Sampoo',8,'bootle','OT')
GO
-- Datetime mac dinh ymd
set dateformat dmy
INSERT INTO tbOrder (OrderDate,CUSTID) VALUES('30-08-2014','C01'),
('31/10/2014','C01'),
('07/11/2014','C03'),
('07/11/2014','C02')
GO
SELECT * FROM tbOrder;
GO

INSERT INTO tbOrderDetail VALUES(300,'P01',3),
(300,'P03',1),
(301,'P02',8),
(301,'P03',1),
(301,'P05',15),
(302,'P06',5),
(303,'P02',4)
GO

SElECT * FROM tbCustomer;
SELECT * FROM tbProduct ORDER BY UnitPrice 
GO
--4c
SELECT tbOrder.ORDERID, tbOrder.OrderDate, tbCustomer.FullName,tbProduct.ProName,Quantity,tbProduct.Unit,tbProduct.UnitPrice,tbProduct.UnitPrice*Quantity amount
FROM tbOrderDetail
INNER JOIN tbOrder ON tbOrder.ORDERID = tbOrderDetail.ORDERID 
INNER JOIN tbProduct ON tbProduct.PROID=tbOrderDetail.PROID
INNER JOIN tbCustomer ON tbCustomer.CUSTID = tbOrder.CUSTID

--4d 
SELECT ProName
FROM tbProduct JOIN tbCategory ON tbProduct.CATID = tbCategory.CATID
WHERE tbProduct.CATID= 'FO'
GO
--4e
SELECT CATID,COUNT(*) 
FROM tbProduct
GROUP BY CATID
GO

--4f
SELECT * FROM tbCustomer INNER JOIN tbOrder ON tbOrder.CUSTID= tbCustomer.CUSTID
WHERE tbOrder.ORDERID = 302
GO

--4g ??
SELECT ORDERID,COUNT(*) AS ITEMS FROM tbOrderDetail 
GROUP BY ORDERID
HAVING COUNT(*) >1
GO
--4h ??
SELECT TOP 2 tbOrderDetail.PROID, ProName,SUM(Quantity)
FROM tbOrderDetail
INNER JOIN tbProduct ON tbOrderDetail.PROID = tbProduct.PROID 
GROUP BY tbOrderDetail.PROID ,ProName
GO