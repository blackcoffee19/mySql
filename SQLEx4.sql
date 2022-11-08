DROP DATABASE StudentDB
GO
CREATE DATABASE StudentDB
ON PRIMARY
(NAME='StudentDB',FILENAME='C:\DATA\StudentDB.mdf',
SIZE=5MB, MAXSIZE=unlimited, FILEGROWTH=10%)
LOG ON (NAME='StudentDB_log',FILENAME='C:\DATA\StudentDB.ldf',
SIZE=2MB, MAXSIZE=15MB, FILEGROWTH=1MB)
GO

CREATE TABLE tbStudents(
	Roll_no INT IDENTITY PRIMARY KEY NOT NULL,
	Fullname varchar(40) NOT NULL,
	Grade varchar(1) CHECK(Grade='A'OR Grade='B' OR Grade='C') NOT NULL,
	Sex varchar(6) DEFAULT 'Female',
	Address varchar(60),
	DOB DATE
)

--2
INSERT INTO tbStudents (Fullname,Grade,Sex,Address,DOB)
VALUES('Rita','B','Female','New York','04/12/1985'),
('Beck','A','Male','California','12/23/1986'),
('Wilson','B','Male','New Jersey','07/09/1988'),
('Leonard','C','Male','Ohio','12/17/1987'),
('Julia','A','Female','Chicago','01/31/1986'),
('Ringo','A','Male','Atlanta','12/18/1985'),
('Annie','C','Female','Washington','04/15/1988'),
('Sandra','C','Female','California','09/12/1986'),
('Tom','A','Male','Ohio','08/01/1987'),
('Susie','B','Female','California','12/03/1988'),
('Bob','B','Male','Washington','12/04/1987'),
('Rosy','C','Female','New York','03/05/1985')
GO

--3
CREATE TABLE tbBatch (
	Batch_no varchar(10) PRIMARY KEY,
	Course_name varchar(40) NOT NULL,
	Start_date DATE
)
INSERT INTO tbBatch VALUES('F2_1401','ACCP 2011','01/02/2014'),
('F2_1402','ACCP 2011','02/01/2014'),
('F2_1403','ACCP 2013 new','03/05/2014'),
('F2_1404','ACCP 2011','02/02/2014'),
('F2_1405','ACCP 2013 new','04/03/2014')
GO

CREATE TABLE tbRegister (
	Batch_no varchar(10),
	Roll_no INT,
	Comment varchar(100),
	Register_date DATE DEFAULT getdate()
	FOREIGN KEY(Roll_no) REFERENCES tbStudents(Roll_no),
	FOREIGN KEY(Batch_no) REFERENCES tbBatch(Batch_no),
)
GO
SELECT * FROM tbStudents
INSERT INTO tbRegister VALUES('F2_1402',2,'Good Student','10/11/2010'),
('F2_1404',6,'Bad Student','10/11/2007'),
('F2_1403',5,'Excellent Student','10/12/2010'),
('F2_1402',9,'Evil Student','02/11/2000'),
('F2_1401',10,'Generious Student','10/11/2009')
GO
SELECT * FROM tbRegister 