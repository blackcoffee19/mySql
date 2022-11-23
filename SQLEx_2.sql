CREATE DATABASE Exercise2
GO
USE Exercise2
CREATE TABLE Students (
	StudentID INT IDENTITY(1,1),
	Name VARCHAR(50),
	Age TINYINT,
	stGender BIT
)
GO
INSERT INTO Students VALUES('Joe Hart',25,1),
							('Colin Doyle',20,1),
							('Paul Robinson',16,NULL),
							('Luis Paulson',17,0),
							('Ben Foster',30,1),
							('Enid Sinclair',17,0),
							('Wednesday Addams',16,0)
GO

CREATE TABLE Projects (
	PID INT IDENTITY(1,1),
	PName VARCHAR(50),
	Cost FLOAT,
	Type VARCHAR(10)
)
GO
INSERT INTO Projects VALUES ('New York Bridge',100,'Normal'),
							('Tenda Road',60,'Education'),
							('Google Road',200,'Government'),
							('Star Bridge',50,'Education')
GO

CREATE TABLE StudentProject (
	StudentID INT, 
	PID INT,
	WorkDate DATE,
	Duration INT
)
GO
SET DATEFORMAT dmy
INSERT INTO StudentProject VALUES (1,4,'15/05/2018',3),
									(2,2,'14/05/2018',5),
									(2,3,'20/05/2018',6),
									(2,1,'16/05/2018',4),
									(3,1,'16/05/2018',6),
									(3,4,'19/05/2018',7),
									(4,4,'21/05/2018',7)
GO
UPDATE StudentProject
SET Duration = 8
WHERE StudentID =4

--3a Constraint CHECK in column Age of Students table with range from 15 to 33
ALTER TABLE Students 
ADD CONSTRAINT Age CHECK (Age BETWEEN 15 AND 33)
GO

--3b Primary key : StudentID of Students, PID of Projects, (StudentID, PID) of StudentProject
ALTER TABLE StudentProject
ALTER COLUMN StudentID INT NOT NULL
ALTER TABLE StudentProject
ALTER COLUMN PID INT NOT NULL
ALTER TABLE Projects
ALTER COLUMN PID INT NOT NULL
ALTER TABLE Students
ALTER COLUMN StudentID INT NOT NULL

ALTER TABLE Students
ADD CONSTRAINT PK_studentid PRIMARY KEY (StudentID)
GO
ALTER TABLE Projects
ADD CONSTRAINT PK_pid PRIMARY KEY (PID)
GO

ALTER TABLE StudentProject
ADD CONSTRAINT PK_StudentPID PRIMARY KEY (StudentID,PID)
GO
--3c Default value on Duration column of StudentProject is 0
ALTER TABLE StudentProject
ADD CONSTRAINT df_duration
DEFAULT 0 FOR Duration
GO
--3d Constraint Foreign key on 3 tables
ALTER TABLE StudentProject
ADD CONSTRAINT FK_studentid FOREIGN KEY (StudentID) REFERENCES Students(StudentID) 
GO
ALTER TABLE StudentProject
ADD CONSTRAINT FK_pid FOREIGN KEY (PID) REFERENCES Projects(PID) 
GO

--4 Displays the names of students working for more than 1 project
SELECT s.StudentID, s.Name
FROM Students s
WHERE s.StudentID IN (SELECT sp.StudentID FROM StudentProject sp GROUP BY sp.StudentID HAVING COUNT(*) >1 )
GO
--5 Displays the names of students who have the largest total working time for projects
SELECT TOP 1 s.StudentID, s.Name, sp.Duration
FROM Students s INNER JOIN StudentProject sp ON s.StudentID=sp.StudentID
ORDER BY sp.Duration DESC
GO

--6 Display the names of students that contain the word "Paul" and fowork r the "Star Bridge" project
SELECT s.StudentID, s.Name, p.PID, p.PName
FROM StudentProject sp INNER JOIN Students s ON s.StudentID = sp.StudentID
						INNER JOIN Projects p ON p.PID = sp.PID
WHERE s.Name LIKE '%Paul%'
AND p.PName = 'Star Bridge'
GO

-- 7 Create a view "vwStudentProject" view to display the following information (sort data incrementally by student name): Student name, Project name, Workdate and Duration

CREATE VIEW vwStudentProject 
AS
	SELECT TOP 100 PERCENT s.Name, p.PName,sp.WorkDate,sp.Duration
	FROM Students s JOIN StudentProject sp ON s.StudentID = sp.StudentID 
							JOIN Projects p ON p.PID=sp.PID
	ORDER BY s.Name
GO
SELECT * FROM vwStudentProject sp

-- 8 Create a stored procedure  "uspWorking" with a parameter, this parameter is contain the Student Name
-- If this name is in the Students table, it will display information about the corresponding Student and Projects that the Student worked on
-- If the parameter is 'any', display the names of all students and the projects they worked.
CREATE PROC uspWorking @name VARCHAR(50) = NULL
AS 
	IF @name IN  (SELECT s.Name FROM Students s)
	BEGIN
		SELECT sp.StudentID, sp.PID, s.Name, s.Age, s.stGender, p.PName, p.Cost, p.Type, sp.WorkDate, sp.Duration
		FROM StudentProject sp JOIN Students s ON s.StudentID = sp.StudentID JOIN Projects p ON p.PID = sp.PID
		WHERE s.Name = @name
	END 
	ELSE
	BEGIN 
		SELECT sp.StudentID, sp.PID, s.Name, s.Age, s.stGender, p.PName, p.Cost, p.Type, sp.WorkDate, sp.Duration
		FROM StudentProject sp JOIN Students s ON s.StudentID = sp.StudentID JOIN Projects p ON p.PID = sp.PID
	END
GO
 DROP PROC uspWorking
EXEC uspWorking 'Joe Hart'
EXEC uspWorking

-- 9 Create a trigger "tgUpdateID" on the Students table, if modify the value on the StudentID column of the Students table, the corresponding value on the StudentID column of the StudentProject table must also be fixed
CREATE TRIGGER tgUpdateID 
ON Students
FOR INSERT
AS 
	UPDATE StudentProject SET StudentID = (SELECT StudentID FROM INSERTED);
	UPDATE Students SET StudentID = (SELECT StudentID FROM INSERTED)
GO
--10 Create a stored procedure "uspDropOut" with a parameter, which contains the name of the Project. If this name is in the Projects table, it will delete all information related to that project in all related tables of the Database.

CREATE PROC uspDropOut @nameP VARCHAR(40)
AS 
	IF EXISTS(
    	SELECT p.PName
    	FROM dbo.Projects p WHERE p.PName = @nameP
    ) BEGIN
		DELETE StudentProject
		WHERE PID = (SELECT p.PID FROM Projects p WHERE p.PName = @nameP);
		DELETE Projects
		WHERE PName = @nameP
		END
GO

EXEC uspDropOut 'Google Road'

SELECT * FROM Students;
SELECT * FROM Projects;
SELECT * FROM StudentProject;


