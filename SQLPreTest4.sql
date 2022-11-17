CREATE DATABASE dbPretest4
GO

USE dbPretest4

CREATE TABLE tbStudents (
    stID VARCHAR(5) PRIMARY KEY,
    stName VARCHAR(50) NOT NULL,
    stAge TINYINT CHECK (stAge >=14 AND stAge <= 70),
    stGender BIT DEFAULT(1)
)
GO
CREATE TABLE tbProjects (
    pID VARCHAR(5) PRIMARY KEY,
    pName VARCHAR(50) NOT NULL UNIQUE,
    pType VARCHAR(5) CHECK(pType = 'EDU' OR pType='DEP' OR pType='GOV'),
    pStartDate DATE NOT NULL DEFAULT(GETDATE())
)
GO

CREATE TABLE tbStudentProject (
    studentID VARCHAR(5) NOT NULL FOREIGN KEY REFERENCES tbStudents(stID),
    projectID VARCHAR(5) NOT NULL FOREIGN KEY REFERENCES tbProjects(pID),
    joinedDate DATE NOT NULL DEFAULT(GETDATE()),
    rate TINYINT CHECK(rate BETWEEN 1 AND 5)
    PRIMARY KEY (studentID, projectID)
)
GO

--3

INSERT INTO tbStudents VALUES('S01','Tom Hanks',18,1),
                            ('S02','Phil Collins',18,1),
                            ('S03','Jennifer Aniston',19,0),
                            ('S04','Jane Fonda',20,0),
                            ('S05','Cristiano Ronaldo',24,1)
GO

set dateformat dmy
INSERT INTO tbProjects VALUES('P20','Social Network','GOV','12/01/2020'),
('P21','React Navtive + NodeJS','EDU','22/08/2020'),
('P22','Google Map API','DEP','15/10/2019'),
('P23','nCovid Vaccine','GOV','16/05/2020')
GO

INSERT INTO tbStudentProject VALUES ('S01','P20','12/02/2020',4),
('S01','P21','12/03/2020',5),
('S02','P20','16/02/2020',3),
('S02','P22','01/09/2020',5),
('S04','P21','12/04/2020',4),
('S04','P22','01/10/2020',3),
('S04','P20','16/10/2020',3),
('S03','P23','04/07/2020',5)
GO
--5 
CREATE VIEW vwStudentProject 
WITH SCHEMABINDING
AS
    SELECT SP.studentID,S.stName,S.stAge,P.pName,P.pStartDate,joinedDate,rate
    FROM dbo.tbStudentProject SP JOIN dbo.tbStudents S ON SP.studentID = S.stID
    JOIN dbo.tbProjects P ON SP.projectID = P.pID 
    WHERE joinedDate < '01-06-2020' 
    WITH CHECK OPTION
GO

SELECT * FROM vwStudentProject

--6 
CREATE PROCEDURE upRating @student_name VARCHAR(50) = NULL, @avg_rate FLOAT = NULL OUTPUT
AS 
    IF @student_name IS NULL
    BEGIN
        SELECT SP.studentID, S.stName, P.pID,P.pName,P.pType,P.pStartDate
        FROM tbStudentProject SP JOIN tbStudents S ON SP.studentID = S.stID
        JOIN tbProjects P ON SP.projectID = P.pID
    END
    ELSE 
    BEGIN 
        SELECT SP.studentID,S.stName,S.stAge,AVG(rate)
        FROM tbStudentProject SP JOIN tbStudents S ON SP.studentID = S.stID
        WHERE S.stName = @student_name 
        GROUP BY SP.studentID,S.stName,S.stAge
        SELECT @avg_rate = AVG(SP.rate)
        FROM tbStudentProject SP JOIN tbStudents S ON SP.studentID = S.stID
        WHERE S.stName = @student_name 
        GROUP BY SP.studentID,S.stName,S.stAge
    END
GO
DECLARE @AvgRate FLOAT;
EXEC upRating 'Jane Fonda',@AvgRate OUTPUT;
PRINT 'Rating trung binh Project cua Jane Fonda = '+CONVERT(VARCHAR(20),@AvgRate);
EXEC upRating 

DROP PROC upRating