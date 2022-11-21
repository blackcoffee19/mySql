CREATE DATABASE CarDB
ON PRIMARY
(NAME='CarDB',FILENAME='C:\DATA\CarDB.mdf',
SIZE=2MB, MAXSIZE=UNLIMITED, FILEGROWTH=1MB),
FILEGROUP myFileGroup
(NAME='CarDB_secondary',FILENAME='C:\DATA\CarDB.ndf',
SIZE=2MB, MAXSIZE=UNLIMITED, FILEGROWTH=1MB)
LOG ON (NAME='CarDB_log',FILENAME='C:\DATA\CarDB.ldf',
SIZE=2MB, MAXSIZE=UNLIMITED, FILEGROWTH=1MB)
GO
USE CarDB

CREATE TABLE Car(
    CarCode INT IDENTITY(1,1) PRIMARY KEY,
    CarName VARCHAR(50) NOT NULL UNIQUE,
    Price MONEY CHECK(Price BETWEEN 1 AND 100000)
)
GO
CREATE TABLE Bill (
    BillCode INT IDENTITY(1,1) PRIMARY KEY,
    BillDate DATETIME CHECK(BillDate <= GETDATE()) NOT NULL
)
GO
CREATE TABLE BillDetail (
    OrdNo INT IDENTITY(1,1),
    BillCode INT FOREIGN KEY REFERENCES Bill(BillCode),
    CarCode INT FOREIGN KEY REFERENCES Car(CarCode),
    Qty INT CHECK (Qty BETWEEN 1 AND 100)
    PRIMARY KEY (BillCode, CarCode)
)
GO

INSERT INTO Car (CarName,Price) VALUES('Chervrolet Camaro ZL1',32000),
                                        ('Lamboghini',100000),
                                        ('Honda Cirvic',1000),
                                        ('Toyota Camry',3000),
                                        ('Lexus',2000)
GO
set dateformat dmy
INSERT INTO Bill (BillDate) VALUES ('12-12-2010'),('09-01-2012'),('02-02-2014'),('15-09-2019'),('11-07-2022')
GO
INSERT INTO BillDetail (BillCode, CarCode, Qty) VALUES (1,4,2),
                                                        (2,5,1),
                                                        (5,3,2),
                                                        (4,6,5),
                                                        (4,7,1)
GO
SELECT * FROM Bill

--R4

