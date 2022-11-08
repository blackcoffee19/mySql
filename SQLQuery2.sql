--Tao Database moi EmployeeDB
CREATE DATABASE EmployeeDB
GO
--Su dung database
USE EmployeeDB
GO
--Tao bang Employee
CREATE TABLE Employee
(
	EmpID varchar(50) NOT NULL,
	EmpName varchar(50) NOT NULL,
	EmpGender varchar(50)
)
GO

--Sua Cot
ALTER TABLE Employee
ALTER COLUMN EmpGender varchar(20)
GO

--them Cot moi
ALTER TABLE Employee
 ADD EmpAge int
 GO

 --Xoa Cot
ALTER TABLE Employee
 DROP COLUMN EmpAge
 GO

 --Tao khoa chinh Primary key cho Employee
AlTER TABLE Employee
ADD CONSTRAINT	pk_EmpID PRIMARY KEY (EmpID)
GO

--Tao 1 bang moi ten la Department
CREATE TABLE Department
(
	DepID int IDENTITY PRIMARY KEY NOT NULL,
	DepName varchar(50)
)
GO

--Them Khoa ngoai de tao moi quan he rang buoc cho 2 bang
--dau tien them cot moi truoc
ALTER TABLE Employee
ADD DepID int
GO

--Sau do them rang buoc khoa ngoai
ALTER TABLE Employee
ADD CONSTRAINT fk_DepID FOREIGN KEY (DepID) REFERENCES Department(DepID)
GO

--Rang buoc CHECK: gioi tinh chi bao gom 2 gia tri laf 'Male' or 'Female'
ALTER TABLE Employee
ADD CONSTRAINT ck_gender CHECK(EmpGender='Male' OR EmpGender='Female')
GO

--Them du lieu vao bang Department truoc -- vi bang Employee co tham khao thong tin cua bang Department
INSERT INTO Department VALUES ('IT')
INSERT INTO Department VALUES ('KT')
INSERT INTO Department VALUES ('HC')
INSERT INTO Department VALUES ('QT')
INSERT INTO Department VALUES ('NS')
GO

--KIem tra xem co du lieu trong bang Department chua?
SELECT * FROM Department
GO

--Them du lieu cho bang Employee
INSERT INTO Employee VALUES ('E01','TUONG','Female',1),
('E02','An','Male',2),
('E03','Hai','Male',3),
('E04','Hang','Female',1)
GO

--Kiem tra du lieu cua bang Employee
SELECT * FROM Employee
GO

--Thay doi du lieu trong bang
UPDATE Employee SET DepID=1 WHERE EmpName='An'
GO
UPDATE Employee SET EmpName='Tuong' WHERE EmpName='TUONG'
GO

--Xoa du lieu trong bang
DELETE Employee WHERE EmpName LIKE 'Hai'
GO