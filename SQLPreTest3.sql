CREATE DATABASE dbPreTest3
GO
USE dbPreTest3
GO
CREATE TABLE tbEmpDetail (
    Emp_Id VARCHAR(5) PRIMARY KEY,
    FullName VARCHAR(30) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    Designation VARCHAR(30) CHECK (Designation='Manager' OR Designation='Staff'),
    Salary MONEY CHECK(Salary>=0 AND Salary <=3000),
    Join_date DATETIME
)
GO

CREATE TABLE tbLeaveDetails (
    Leave_ID INT IDENTITY(1,1) PRIMARY KEY,
    Emp_ID VARCHAR(5) FOREIGN KEY REFERENCES tbEmpDetail(Emp_ID),
    LeaveTaken INT CHECK(LeaveTaken>0 AND LeaveTaken<15),
    FromDate DATETIME,
    ToDate DATETIME,
    Reason VARCHAR(50) NOT NULL
)
GO

--3 Insert at least five records to each table
set dateformat dmy
INSERT INTO tbEmpDetail VALUES ('Emp01','Di Di','020123123','Staff',2000,'21-02-1999'),
                                ('Emp02','Coffee','091232423','Staff',2500,'14-05-2004'),
                                ('Emp03','Tuong','091394434','Staff',1700,'23-12-2021'),
                                ('Emp04','Irisk','0239434232','Manager',2100,'01-07-2008'),
                                ('Emp05','Amantha','081234672','Manager',2800,'02-02-2019')
GO
INSERT INTO tbLeaveDetails (Emp_ID,LeaveTaken,FromDate,ToDate,Reason) VALUES
('Emp01',10,'01-01-2000','01-06-2000','Do a project'),
('Emp02',12,'01-05-2010','01-06-2011','Do a project'),
('Emp05',3,'01-01-2020','01-12-2020','Do a project'),
('Emp04',9,'01-03-2020','01-06-2021','Do a project'),
('Emp01',7,'31-12-2010','01-09-2011','Do a project')
GO

--5 Create a view vwManager to retrieve the number of leaves taken by employees having designation as Manager
CREATE VIEW vwManager 
WITH SCHEMABINDING
AS 
    SELECT LD.Emp_ID, EM.FullName,EM.Designation,LD.LeaveTaken,LD.FromDate,LD.ToDate
    FROM dbo.tbLeaveDetails LD JOIN dbo.tbEmpDetail EM ON  LD.Emp_ID = EM.Emp_Id
    WHERE EM.Designation = 'Manager'
GO

SELECT * FROM vwManager
GO

--6 Create a store procedure uspChangeSalary to increase salary of an employee by a given value (Hint: using input parameters)
CREATE PROC uspChangeSalary @num INT
AS 
    UPDATE tbEmpDetail
    SET Salary = Salary + @num
GO
SELECT Emp_Id, FullName,Designation, Salary FROM tbEmpDetail
EXEC uspChangeSalary 200
GO
--7 Create a trigger tgInsertLeave for table tbLeaveDetails which will perform rollback transaction if total of leaves taken by employees in a year greater than 15 and display appropriate error message.
USE dbPreTest3
SELECT * FROM tbLeaveDetails
CREATE TRIGGER tgInsertLeave 
ON tbLeaveDetails 
FOR INSERT
AS 
    IF(SELECT SUM(LeaveTaken) FROM tbLeaveDetails WHERE Emp_ID IN (SELECT Emp_ID FROM inserted))>15
    BEGIN 
        PRINT 'Employee cant leaves taken in a year greater than 15'
        ROLLBACK
    END
GO
DROP TRIGGER tgInsertLeave
set dateformat dmy
INSERT INTO tbLeaveDetails(Emp_ID,LeaveTaken,FromDate,ToDate,Reason) VALUES ('Emp02',12,'01-05-2010','01-06-2011','Do a project')
GO

--8 Create a trigger tgUpdateEmploee for table tbEmployeeDetails which removes the employee if new salary is reset to zero. 
INSERT INTO tbLeaveDetails VALUES('Emp03',1,'20-10-2000','20-12-2000',''),
                                ('Emp04',3,'20-10-2000','20-12-2000',''),
                                ('Emp04',1,'20-10-2001','20-12-2002','')
GO
DELETE tbLeaveDetails
WHERE Emp_Id IN (SELECT Emp_ID FROM tbLeaveDetails WHERE Emp_ID = 'Emp04');
DELETE tbEmpDetail
WHERE Emp_Id = 'Emp04'
GO
SELECT * FROM tbEmpDetail
CREATE TRIGGER tgUpdateEmploee
ON tbEmpDetail
FOR UPDATE
AS  
    IF (SELECT Salary FROM inserted) =0
    BEGIN   
        DELETE tbLeaveDetails
        WHERE Emp_Id IN (SELECT Emp_Id FROM tbLeaveDetails WHERE Emp_ID IN (SELECT Emp_ID FROM inserted));
        DELETE tbEmpDetail
        WHERE Emp_Id IN (SELECT Emp_Id FROM inserted)
    END
GO
DROP TRIGGER tgUpdateEmploee
SELECT * FROM tbEmpDetail
SELECT * FROM tbLeaveDetails
UPDATE tbEmpDetail
SET Salary = 0
WHERE FullName='Coffee'
GO