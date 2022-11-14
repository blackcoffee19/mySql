CREATE DATABASE SaleDB;

USE SaleDB
GO

CREATE TABLE Customer(
    CustomerID  CHAR(4) PRIMARY KEY,
    CustName VARCHAR(40),
    CustAddress VARCHAR(50),
    CustPhone VARCHAR(20),
    Birthday DATE,
    ResgisterDate DATE,
    Revenue MONEY
)
GO
CREATE TABLE Employee(
    EmpID CHAR(4) PRIMARY KEY,
    EmpName VARCHAR(40),
    EmpPhone VARCHAR(20),
    StartDate DATE
)
GO
CREATE TABLE Product(
    ProductID CHAR(4) PRIMARY KEY,
    ProductName VARCHAR(40),
    Unit VARCHAR(20),
    Country VARCHAR(40),
    Price MONEY
)
GO
CREATE TABLE Bill(
    BillID INT PRIMARY KEY,
    BillDate DATE,
    CustomerID CHAR(4) FOREIGN KEY REFERENCES Customer(CustomerID),
    EmpID CHAR(4) FOREIGN KEY REFERENCES Employee(EmpID),
    BillVAl MONEY
)
GO
CREATE TABLE DetailBill(
    BillID INT FOREIGN KEY REFERENCES Bill(BillID),
    ProductID CHAR(4) FOREIGN KEY REFERENCES Product(ProductID),
    Quantity INT,
    PRIMARY KEY(BillID,ProductID)
)

--INSERT INTO TABLE
set dateformat dmy
insert into Customer values('C01','Nguyen Van A','731 Tran Hung Dao, Q5, TpHCM','8823451','22/10/1960','22/07/2006',13060000)
insert into Customer values('C02','Tran Ngoc Han','23/5 Nguyen Trai, Q5, TpHCM','908256478','03/04/1974','30/07/2006',280000)
insert into Customer values('C03','Tran Ngoc Linh','45 Nguyen Canh Chan, Q1, TpHCM','938776266','12/06/1980','08/05/2006',3860000)
insert into Customer values('C04','Tran Minh Long','50/34 Le Dai Hanh, Q10, TpHCM','917325476','09/03/1965','10/02/2006',250000)
insert into Customer values('C05','Le Nhat Minh','34 Truong Dinh, Q3, TpHCM','8246108','10/03/1950','28/10/2006',21000)
insert into Customer values('C06','Le Hoai Thuong','227 Nguyen Van Cu, Q5, TpHCM','8631738','31/12/1981','24/11/2006',915000)
insert into Customer values('C07','Nguyen Van Tam','32/3 Tran Binh Trong, Q5, TpHCM','916783565','06/04/1971','12/01/2006',12500)
insert into Customer values('C08','Phan Thi Thanh','45/2 An Duong Vuong, Q5, TpHCM','938435756','10/01/1971','13/12/2006',365000)
insert into Customer values('C09','Le Ha Vinh','873 Le Hong Phong, Q5, TpHCM','8654763','03/09/1979','14/01/2007',70000)
insert into Customer values('C10','Ha Duy Lap','34/34B Nguyen Trai, Q1, TpHCM','8768904','02/05/1983','16/01/2007',67500)

insert into Employee values('E01','Nguyen Nhu Nhut','927345678','13/04/2006')
insert into Employee values('E02','Le Thi Phi Yen','987567390','21/04/2006')
insert into Employee values('E03','Nguyen Van B','997047382','27/04/2006')
insert into Employee values('E04','Ngo Thanh Tuan','913758498','24/06/2006')
insert into Employee values('E05','Nguyen Thi Truc Thanh','918590387','20/07/2006')

insert into Product values('BC01','But chi','cay','Singapore',3000)
insert into Product values('BC02','But chi','cay','Singapore',5000)
insert into Product values('BC03','But chi','cay','Viet Nam',3500)
insert into Product values('BC04','But chi','hop','Viet Nam',30000)
insert into Product values('BB01','But bi','cay','Viet Nam',5000)
insert into Product values('BB02','But bi','cay','Trung Quoc',7000)
insert into Product values('BB03','But bi','hop','Thai Lan',100000)
insert into Product values('TV01','Tap 100 giay mong','quyen','Trung Quoc',2500)
insert into Product values('TV02','Tap 200 giay mong','quyen','Trung Quoc',4500)
insert into Product values('TV03','Tap 100 giay tot','quyen','Viet Nam',3000)
insert into Product values('TV04','Tap 200 giay tot','quyen','Viet Nam',5500)
insert into Product values('TV05','Tap 100 trang','chuc','Viet Nam',23000)
insert into Product values('TV06','Tap 200 trang','chuc','Viet Nam',53000)
insert into Product values('TV07','Tap 100 trang','chuc','Trung Quoc',34000)
insert into Product values('ST01','So tay 500 trang','quyen','Trung Quoc',40000)
insert into Product values('ST02','So tay loai 1','quyen','Viet Nam',55000)
insert into Product values('ST03','So tay loai 2','quyen','Viet Nam',51000)
insert into Product values('ST04','So tay','quyen','Thai Lan',55000)
insert into Product values('ST05','So tay mong','quyen','Thai Lan',20000)
insert into Product values('ST06','Phan viet bang','hop','Viet Nam',5000)
insert into Product values('ST07','Phan khong bui','hop','Viet Nam',7000)
insert into Product values('ST08','Bong bang','cai','Viet Nam',1000)
insert into Product values('ST09','But long','cay','Viet Nam',5000)
insert into Product values('ST10','But long','cay','Trung Quoc',7000)

insert into Bill values(1001,'23/07/2006','C01','E01',320000)
insert into Bill values(1002,'12/08/2006','C01','E02',840000)
insert into Bill values(1003,'23/08/2006','C02','E01',100000)
insert into Bill values(1004,'01/09/2006','C02','E01',180000)
insert into Bill values(1005,'20/10/2006','C01','E02',3800000)
insert into Bill values(1006,'16/10/2006','C01','E03',2430000)
insert into Bill values(1007,'28/10/2006','C03','E03',510000)
insert into Bill values(1008,'28/10/2006','C01','E03',440000)
insert into Bill values(1009,'28/10/2006','C03','E04',200000)
insert into Bill values(1010,'01/11/2006','C01','E01',5200000)
insert into Bill values(1011,'04/11/2006','C04','E03',250000)
insert into Bill values(1012,'30/11/2006','C05','E03',21000)
insert into Bill values(1013,'12/12/2006','C06','E01',5000)
insert into Bill values(1014,'31/12/2006','C03','E02',3150000)
insert into Bill values(1015,'01/01/2007','C06','E01',910000)
insert into Bill values(1016,'01/01/2007','C07','E02',12500)
insert into Bill values(1017,'02/01/2007','C08','E03',35000)
insert into Bill values(1018,'13/01/2007','C08','E03',330000)
insert into Bill values(1019,'13/01/2007','C01','E03',30000)
insert into Bill values(1020,'14/01/2007','C09','E04',70000)
insert into Bill values(1021,'16/01/2007','C10','E03',67500)
insert into Bill values(1022,'16/01/2007',Null,'E03',7000)
insert into Bill values(1023,'17/01/2007',Null,'E01',330000)

insert into DetailBill values(1001,'TV02',10)
insert into DetailBill values(1001,'ST01',5)
insert into DetailBill values(1001,'BC01',5)
insert into DetailBill values(1001,'BC02',10)
insert into DetailBill values(1001,'ST08',10)
insert into DetailBill values(1002,'BC04',20)
insert into DetailBill values(1002,'BB01',20)
insert into DetailBill values(1002,'BB02',20)
insert into DetailBill values(1003,'BB03',10)
insert into DetailBill values(1004,'TV01',20)
insert into DetailBill values(1004,'TV02',10)
insert into DetailBill values(1004,'TV03',10)
insert into DetailBill values(1004,'TV04',10)
insert into DetailBill values(1005,'TV05',50)
insert into DetailBill values(1005,'TV06',50)
insert into DetailBill values(1006,'TV07',20)
insert into DetailBill values(1006,'ST01',30)
insert into DetailBill values(1006,'ST02',10)
insert into DetailBill values(1007,'ST03',10)
insert into DetailBill values(1008,'ST04',8)
insert into DetailBill values(1009,'ST05',10)
insert into DetailBill values(1010,'TV07',50)
insert into DetailBill values(1010,'ST07',50)
insert into DetailBill values(1010,'ST08',100)
insert into DetailBill values(1010,'ST04',50)
insert into DetailBill values(1010,'TV03',100)
insert into DetailBill values(1011,'ST06',50)
insert into DetailBill values(1012,'ST07',3)
insert into DetailBill values(1013,'ST08',5)
insert into DetailBill values(1014,'BC02',80)
insert into DetailBill values(1014,'BB02',100)
insert into DetailBill values(1014,'BC04',60)
insert into DetailBill values(1014,'BB01',50)
insert into DetailBill values(1015,'BB02',30)
insert into DetailBill values(1015,'BB03',7)
insert into DetailBill values(1016,'TV01',5)
insert into DetailBill values(1017,'TV02',1)
insert into DetailBill values(1017,'TV03',1)
insert into DetailBill values(1017,'TV04',5)
insert into DetailBill values(1018,'ST04',6)
insert into DetailBill values(1019,'ST05',1)
insert into DetailBill values(1019,'ST06',2)
insert into DetailBill values(1020,'ST07',10)
insert into DetailBill values(1021,'ST08',5)
insert into DetailBill values(1021,'TV01',7)
insert into DetailBill values(1021,'TV02',10)
insert into DetailBill values(1022,'ST07',1)
insert into DetailBill values(1023,'ST04',6)

--C Query
--1 Show ProductID, ProductName produced by “Viet Nam”
SELECT ProductID, ProductName, Country
FROM Product 
WHERE Country = 'Viet Nam'
GO

--2 Show ProductID, ProductName has unit is “cay”, “quyen”
SELECT ProductID, ProductName, Unit
FROM Product
WHERE Unit = 'cay' OR Unit = 'quyen'
GO

--3 Show ProductID, ProductName has product code start by “B” and end by “01”
SELECT ProductID, ProductName
FROM Product
WHERE LEFT(ProductID,1) = 'B' AND RIGHT(ProductID,2) = '01'
GO 
SELECT ProductID, ProductName
FROM Product
WHERE ProductID LIKE 'B%01'
GO 
--4 Show ProductID, ProductName produced by “Trung Quoc” and price from 30.000 to 40.000
SELECT ProductID, ProductName,Price
FROM Product
WHERE Country = 'Trung Quoc' 
AND Price BETWEEN 30000 AND 40000
GO

--5 Show ProductID, ProductName produced by “Trung Quoc” or “Viet Nam” and price from 30.000 to 40.000
SELECT ProductID, ProductName,Price,Country
FROM Product
WHERE (Country = 'Trung Quoc' OR Country = 'Viet Nam') 
AND Price BETWEEN 30000 AND 40000
GO
SELECT ProductID, ProductName,Price,Country
FROM Product
WHERE Country IN ('Trung Quoc','Viet Nam') 
AND Price BETWEEN 30000 AND 40000
GO
--6 Show BillID, BillVal are sold on 1/1/2007 and 2/1/2007
--SELECT * FROM Bill
set dateformat dmy
SELECT BillID, BillVAl,BillDate
FROM Bill
WHERE BillDate = '1/1/2007' OR BillDate = '2/1/2007'
GO
SELECT BillID, BillVAl,BillDate
FROM Bill
WHERE BillDate IN ('2007-01-01','2007-01-02')
GO

--7 Show BillID, BillVal are sold on January 2017, order by date (ascending) and invoice value(descending)
SELECT BillID, BillVAl,BillDate
FROM Bill
WHERE YEAR(BillDate) = 2007 AND MONTH(BillDate) = 1
ORDER BY BillDate ASC, BillVAl DESC
GO

--8 Show CustomerID, CustName have bought product on 1/1/2007
SELECT Customer.CustomerID,CustName
FROM Customer INNER JOIN Bill ON Bill.CustomerID = Customer.CustomerID
WHERE Customer.CustomerID = Bill.CustomerID AND 
Bill.BillDate = '2007-01-01'
GO

--9 Show BillID, BillVal are recorded by employee “Nguyen Van B” on 28/10/2006
SELECT BillID, BillVal, Bill.EmpID
FROM Bill
WHERE Bill.BillDate  = '2006-10-28' AND 
Bill.EmpID = (SELECT EmpID FROM Employee 
            WHERE Employee.EmpName = 'Nguyen Van B')
GO

SELECT BillID, BillVal, Bill.EmpID, EmpName, BillDate
FROM Bill INNER JOIN Employee ON Bill.EmpID = Employee.EmpID
WHERE EmpName = 'Nguyen Van B' AND BillDate  = '2006-10-28'
GO

--10 Show ProductID, ProductName are bought by customer “Nguyen Van A” on 10/2006
SELECT Product.ProductID, ProductName,Bill.CustomerID
FROM Product
INNER JOIN DetailBill ON Product.ProductID = DetailBill.ProductID 
INNER JOIN Bill ON DetailBill.BillID = Bill.BillID
WHERE Bill.CustomerID = (SELECT CustomerID FROM Customer 
                        WHERE CustName = 'Nguyen Van A')
AND MONTH(Bill.BillDate)=10 AND YEAR(Bill.BillDate) = 2006 
GO 

SELECT D.ProductID, ProductName, CustName, BillDate
FROM Bill B INNER JOIN Customer C ON B.CustomerID = C.CustomerID
INNER JOIN DetailBill D ON B.BillID = D.BillID
INNER JOIN Product P ON D.ProductID = P.ProductID
WHERE CustName='Nguyen Van A' AND MONTH(BillDate) = 10 AND YEAR(BillDate) = '2006'
GO

--11 Show BillID have ProductID is “BB01” or “BB02”
SELECT DISTINCT BillID
FROM DetailBill
WHERE ProductID = 'BB01' OR ProductID = 'BB02'
GO

--12 Show BillID have ProductID is “BB01” or “BB02” with each quantity from 10 to 20
SELECT DISTINCT BillID
FROM DetailBill
WHERE (ProductID = 'BB01' AND Quantity BETWEEN 10 AND 20)
OR (ProductID = 'BB02' AND Quantity BETWEEN 10 AND 20)
GO

SELECT DISTINCT BillID
FROM DetailBill
WHERE ProductID IN ('BB01','BB02') AND Quantity BETWEEN 10 AND 20
GO


--13 Show BillID have bought 2 products “BB01” and “BB02” at the same time, each quantity from 10 to 20 (hint: use INTERSECT)
SELECT BillID
FROM DetailBill
WHERE (Quantity BETWEEN 10 AND 20)
AND ProductID = 'BB01'
INTERSECT
SELECT BillID
FROM DetailBill
WHERE (Quantity BETWEEN 10 AND 20)
AND ProductID = 'BB02'
GO

--14 Show ProductID, ProductName are produced by “Trung Quoc” and sold on 1/1/2007
SELECT Product.ProductID,ProductName,BillDate,Country 
FROM DetailBill
INNER JOIN Product ON Product.ProductID = DetailBill.ProductID
INNER JOIN Bill ON DetailBill.BillID = Bill.BillID
WHERE Country = 'Trung Quoc' AND Bill.BillDate ='2007-01-01'
GO

--15 Show the revenue in 2006
SELECT SUM(BillVAl) revenue_2006
FROM Bill
WHERE YEAR(BillDate)='2006'
GO

SELECT SUM(BillVAl) revenue_2007
FROM Bill
WHERE YEAR(BillDate)='2007'
GO

SELECT SUM(BillVAl) revenue
FROM Bill
GO

--16 Show ProductID, ProductName not sold (hint: use NOT IN, NOT EXISTS or EXCEPT)
SELECT ProductID,ProductName 
FROM Product 
WHERE NOT EXISTS (SELECT ProductID FROM DetailBill WHERE DetailBill.ProductID = Product.ProductID);
GO

SELECT ProductID,ProductName 
FROM Product 
WHERE ProductID NOT IN (SELECT ProductID FROM DetailBill);
GO


--17 Show ProductID, ProductName not sold in 2006
SELECT ProductID,ProductName
FROM Product
WHERE ProductID NOT IN (SELECT ProductID FROM DetailBill JOIN Bill ON DetailBill.BillID = Bill.BillID WHERE YEAR(BillDate)= '2006')


--18 Show ProductID, ProductName not sold in 2006 produced by “Trung Quoc”
SELECT ProductID,ProductName
FROM Product
WHERE Country = 'Trung Quoc'
AND ProductID NOT IN (SELECT ProductID FROM DetailBill JOIN Bill ON DetailBill.BillID = Bill.BillID WHERE YEAR(BillDate)= '2006')
GO

--19 Show the number of invoices have bought by non-member customer
SELECT COUNT(*)
FROM Bill
WHERE CustomerID IS NULL
GO


--20 Show the number of different products were sold in 2006
SELECT COUNT(DISTINCT ProductID)
FROM DetailBill INNER JOIN Bill ON Bill.BillID = DetailBill.BillID 
WHERE YEAR(Bill.BillDate) = '2006'
GO

--21 Show the highest  and lowest invoice value
SELECT MIN(BillVAl) AS min_bill_val, MAX(BillVAl) AS max_bill_val
FROM Bill
GO

--22 Show the average of invoice value were sold in 2006
SELECT AVG(BillVAl) AS Trung_binh_nam_2006
FROM Bill
WHERE YEAR(BillDate) = '2006'

--23 Show BillID has the highest invoice value in 2006
SELECT BillID 
FROM Bill
WHERE BillVAl = (SELECT MAX(BillVAl) FROM Bill WHERE YEAR(BillDate) = '2006')
GO

-- 24 Show CustName have bought the highest invoice value in 2006
SELECT TOP 1 Bill.BillVAl, Customer.CustName
FROM Customer INNER JOIN Bill ON Bill.CustomerID = Customer.CustomerID
ORDER BY Bill.BillVAl DESC
GO 

SELECT CustName
FROM Customer
WHERE CustomerID = (SELECT TOP 1 CustomerID FROM Bill ORDER BY BillVAl DESC)
GO

--25 Show 3 customers (CustomerID, CustName) have highest revenue
SELECT TOP 3 Revenue,* 
FROM Customer
ORDER BY Customer.Revenue DESC
GO

--26 Show a list of products (ProductID, ProductName) that sells at one of the three highest prices.
SELECT TOP 3 Price, ProductID, ProductName
FROM Product
ORDER BY Product.Price DESC
GO

--27 Show a list of products (ProductID, ProductName) that sells at one of the three highest prices produced by “Thai Lan”
SELECT ProductID, ProductName, Price
FROM Product 
WHERE ProductID IN (SELECT TOP 3 ProductID FROM Product ORDER BY Price DESC) 
AND Country = 'Thai Lan'
GO

--28 Show the total of products produced by “Trung Quoc”
SELECT COUNT(DISTINCT ProductID)
FROM Product
WHERE Country = 'Trung Quoc'
GO

--29 Show the total of products of each country.
SELECT Country, COUNT(ProductID)
FROM Product
GROUP BY Country
GO

--30 Show the revenue per day.
SELECT BillDate, SUM(BillVAl)
FROM Bill
GROUP BY BillDate
GO

--31 Show the customer(CustomerID, CustName) have the number of times purchasing is highest
SELECT CustomerID, CustName
FROM Customer
WHERE CustomerID = (SELECT TOP 1 CustomerID FROM Bill GROUP BY CustomerID ORDER BY COUNT(*) DESC)
GO

--32 Show the country where the total number of products is the largest
SELECT TOP 1 Country, COUNT(*) 
FROM Product
GROUP BY Country
ORDER BY COUNT(ProductID) DESC
GO

--33 Show BillID have bought all products produced by Singapore
SELECT BillID, COUNT(*)
FROM DetailBill INNER JOIN Product ON Product.ProductID = DetailBill.ProductID
WHERE Product.Country = 'Singapore'
GROUP BY BillID
HAVING COUNT(*) = (SELECT COUNT(*) FROM Product WHERE Country = 'Singapore') 
GO

--34 Show BillID have bought all products produced by Singapore in 2006.
SELECT DetailBill.BillID,Bill.BillDate,COUNT(*)
FROM DetailBill INNER JOIN Product ON Product.ProductID = DetailBill.ProductID
INNER JOIN Bill ON Bill.BillID = DetailBill.BillID
WHERE Product.Country = 'Singapore' AND YEAR(Bill.BillDate) = '2006'
GROUP BY DetailBill.BillID,Bill.BillDate
HAVING COUNT(*) = (SELECT COUNT(*) FROM Product WHERE Country = 'Singapore') 
GO


SELECT * FROM Customer
SELECT * FROM Bill
SELECT * FROM DetailBill
SELECT * FROM Employee
SELECT * FROM Product