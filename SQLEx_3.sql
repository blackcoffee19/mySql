CREATE DATABASE Exercise3
GO
USE Exercise3
CREATE TABLE Customer (
	CustomerID INT NOT NULL,
	Name VARCHAR(30),
	Birth DATETIME,
	Gender BIT NULL
)
GO
DROP TABLE Customer
CREATE TABLE Product (
	ProductID INT NOT NULL,
	Name VARCHAR(30),
	PDesc TEXT,
	Pimage VARCHAR(200),
	Pstatus BIT NULL
)
GO
CREATE TABLE Commemt (
	ComID INT IDENTITY(1,1),
	ProductID INT,
	CustomerID INT,
	Date DATETIME,
	Title VARCHAR(200),
	Content TEXT,
	Status BIT
)
GO
SET DATEFORMAT DMY
INSERT INTO Customer (CustomerID, Name, Birth,Gender) VALUES (1,'Jonny Owen','10/10/1980',1),
							(2,'Christina Tiny','10/03/1989',0),
							(3,'Garray Kelly','16/03/1990',NULL),
							(4,'Tammy Beckham','17/05/1980',0),
							(5,'David Phantom','30/12/1987',1)
GO

INSERT INTO Product VALUES (1,'Nokia N90','Mobile Nokia','Image1.jpg',1),
							(2,'HP DV6000','Laptop','Image2.jpg',NULL),
							(3,'HP DV2000','Laptop','Image3.jpg',1),
							(4,'Samsung G488','Mobile Samsung','Image4.jpg',0),
							(5,'LCD Plasma','TV LCD','Image5.jpg',0)
GO

INSERT INTO Commemt VALUES (1,1,'15/03/2009','Hot product',NULL,1),
							(2,2,'14/03/2009','Hot price','Very much',0),
						(3,2,'20/03/2009','Cheapest','Unlimited',0),
						(4,2,'16/04/2009','Sale off','50%',1)
GO

--3 Default value on Date column of Comment is current date
ALTER TABLE Commemt 
ADD CONSTRAINT df_date DEFAULT GETDATE() FOR Date
GO
ALTER TABLE Commemt
ALTER COLUMN CustomerID INT NOT NULL
ALTER TABLE Commemt
ALTER COLUMN ProductID INT NOT NULL
ALTER TABLE Commemt
ADD CONSTRAINT PK_customprodID PRIMARY KEY (CustomerID,ProductID)
GO
ALTER TABLE Customer
ADD CONSTRAINT PK_CustomerID PRIMARY KEY (CustomerID)
ALTER TABLE Product
ADD CONSTRAINT PK_ProductID PRIMARY KEY (ProductID)

ALTER TABLE Commemt
ADD CONSTRAINT FK_customprodID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) 
ALTER TABLE Commemt
ADD CONSTRAINT FK_customprodID2 FOREIGN KEY (ProductID) REFERENCES Product(ProductID) 
GO

ALTER TABLE Product
ADD CONSTRAINT uni UNIQUE (Pimage) 
GO

--4 Displays the products have PStatus is null or 0.
SELECT * FROM Product p WHERE p.Pstatus IS NULL OR p.Pstatus = 0
GO

--5 Displays the products have no comments
SELECT *
FROM Product p
WHERE p.ProductID NOT IN (SELECT c.ProductID FROM Commemt c)
GO

--6 Display the name of customers who have the largest comment.
SELECT p.Name , c.ProductID, COUNT(c.ComID)
FROM Product p INNER JOIN Commemt c ON p.ProductID = c.ProductID
GROUP BY c.ProductID,p.Name
ORDER BY COUNT(c.ComID) DESC
GO

--7 Create a view "vwCustomerList" to display the information of customer includes all the column of Customer and age of customer >=35
CREATE VIEW vwCustomerList
AS
	SELECT * 
	FROM Customer c
	WHERE YEAR(GETDATE() - c.Birth) >= 53
GO

SELECT * FROM vwCustomerList cl

--8 Create a trigger "tgUpdateProduct" on the Product table, if modify the value on the ProductID column of the Product table, the corresponding value on the ProductID column of the Comment table must also be fixed.

CREATE TRIGGER tgUpdateProduct
ON Product
FOR UPDATE
AS 
	UPDATE Commemt 
	SET ProductID = (SELECT ProductID FROM INSERTED)
	WHERE ProductID = (SELECT ProductID FROM INSERTED)
	UPDATE Product
	SET ProductID = (SELECT ProductID FROM INSERTED)
	WHERE ProductID = (SELECT ProductID FROM INSERTED)
GO
DROP TRIGGER tgUpdateProduct
UPDATE Product
SET ProductID = 6
WHERE ProductID = 4

-- 9  Create a stored procedure "uspDropOut" with a parameter, which contains the name of Customer. If this name is in the Customer table, it will delete all information related to this customer in all related tables of the Database

CREATE PROC uspDropOut @name VARCHAR(40)
AS
	IF @name IN (SELECT c.Name FROM Customer c)
		BEGIN
			DELETE Customer WHERE Name = @name
		END
GO
DROP PROC uspDropOut
CREATE TRIGGER del_cust 
ON Customer
INSTEAD OF DELETE
AS
	DELETE Commemt WHERE CustomerID = (SELECT CustomerID FROM DELETED)
	DELETE Customer WHERE Name = (SELECT Name FROM DELETED)
GO

EXEC uspDropOut 'Jonny Owen'

SELECT * FROM Customer c;
SELECT * FROM Product p;
SELECT * FROM Commemt c;
