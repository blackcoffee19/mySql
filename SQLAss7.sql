CREATE DATABASE ASM7
ON PRIMARY 
(NAME='ASM7',FILENAME='/home/blackcoffee/mySql/ASM7.mdf',
SIZE=10MB,MAXSIZE=15MB,FILEGROWTH=20%),
FILEGROUP MyFileGroup
(NAME='ASM72',FILENAME='/home/blackcoffee/mySql/ASM7.ndf',
SIZE=10MB,MAXSIZE=15MB,FILEGROWTH=20%)
LOG ON (NAME='ASM7_log',FILENAME='/home/blackcoffee/mySql/ASM7.ldf',
SIZE=10MB,MAXSIZE=15MB,FILEGROWTH=20%)
GO


CREATE TABLE tbBatch
(
    BatchNo VARCHAR(10) PRIMARY KEY,
    Size INT,
    TimeSlot VARCHAR(20),
    RoomNo VARCHAR(10)
)
GO

CREATE TABLE tbStudent(
    Rollno VARCHAR(10) PRIMARY KEY,
    LastName VARCHAR(20) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    Gender VARCHAR(1) NOT NULL DEFAULT('M'),
    DOB DATETIME,
    Address VARCHAR(40),
    EnrollYear SMALLINT NOT NULL DEFAULT(YEAR(getdate())),
    BatchNo VARCHAR(10) FOREIGN KEY REFERENCES tbBatch(BatchNo)
)
GO

ALTER TABLE tbBatch
ADD CHECK(Size>0 AND Size<6)
GO

ALTER TABLE tbStudent
ADD CHECK(Gender='M' OR Gender='F')
GO

ALTER TABLE tbStudent
ADD CHECK(EnrollYear>=2000)
GO

INSERT INTO tbBatch VALUES('T2009',4,'TMA01','C121'),
                            ('T2012',5,'DCM01','B220'),
                            ('T2022',2,'MAM02','C220'),
                            ('T2021',3,'MSD04','A110')
GO
set dateformat dmy
INSERT INTO tbStudent VALUES('T1919','Do','Tuong','F','01/09/2000','Tan Phu','2022','T2022'),
                            ('T1231','Tran','Anh','F','23/09/2001','Tan Binh','2021','T2021'),
                            ('T2402','Ngu','Lam','F','24/02/2000','Tan Phu','2022','T2022'),
                            ('T2401','Ngu','Nha','F','24/02/2000','Tan Phu','2022','T2022'),
                            ('T2732','Nguyen','Na','M','31/12/2002','Quan 1','2009','T2009'),
                            ('T4614','Nguyen','Hai','M','07/08/2001','Quan 7','2021','T2021'),
                            ('T5932','Lam','Di','M','01/09/1998','Quan 12','2012','T2012'),
                            ('T3452','Luc','Manh','M','23/12/1992','Quan 5','2012','T2012'),
                            ('T6522','Truong','Ai','M','23/09/1997','Quan 11','2009','T2009')
GO

INSERT INTO tbStudent VALUES('T2340','Dang','An','M','23/09/2009','Quan 2','2022','T2022'),
('T3491','Nguyen','Duc','M','23/09/2010','Quan 6','2022','T2022')
GO


--3.a  list of students sorted by gender and date of birth
SELECT Gender,DOB
FROM tbStudent

--3.b count number of students grouped by gender .
SELECT Gender, COUNT(*)
FROM tbStudent
GROUP BY Gender

--3.c list of students who have more 18 year-old, consisting of the columns: rollno, full name (lastname + firstname), gender, dob, address, batchno, roomn
SELECT Rollno, LastName,FirstName, Gender,DOB,Address, S.BatchNo, B.RoomNo
FROM tbStudent S INNER JOIN tbBatch B ON S.BatchNo = B.BatchNo
WHERE (YEAR(GETDATE())- YEAR(S.DOB))>18
GO

--4.Create a view vwSchoolBoy to contain information of schoolboys which consist of columns Rollno, LastName, FirstName, age, BatchNo and Timeslot.
CREATE VIEW vwSchoolBoy 
AS
SELECT Rollno,LastName,FirstName,(YEAR(GETDATE())- YEAR(DOB)) AS AGE, S.BatchNo,B.TimeSlot
FROM tbStudent S INNER JOIN tbBatch B ON S.BatchNo=B.BatchNo
WHERE Gender='M'
WITH CHECK OPTION
GO

SELECT * FROM vwSchoolBoy GO
--5 Create a view vwNewStudent to see information of students enrolled in this year which contained the columns Rollno, full name, gender, DOB, BatchNo, roomNo.
CREATE VIEW vwNewStudent 
AS
SELECT Rollno, (FirstName + LastName) AS FullName, Gender, DOB, S.BatchNo, B.RoomNo
FROM tbStudent S INNER JOIN tbBatch B ON S.BatchNo=B.BatchNo
WHERE EnrollYear = YEAR(GETDATE())
GO


SELECT * FROM vwNewStudent
GO