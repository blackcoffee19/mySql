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