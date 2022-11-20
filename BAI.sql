CREATE DATABASE Exercise1 
GO
USE Exercise1 

CREATE TABLE Students (
	StudentID INT IDENTITY(1,1),
	Name VARCHAR(50),
	Age TINYINT, 
	stGender BIT
)
GO

CREATE TABLE Projects (
	PID INT IDENTITY(1,1),
	PName VARCHAR(50),
	Cost FLOAT,
	Type VARCHAR(10)
)
GO

CREATE TABLE StudentProject(
	StudentID INT,
	PID INT,
	WorkDate DATETIME,
	Duration INT
)
GO

--3 
--a Constraint CHECK in column Age of Students table with range from 15 to 33.
ALTER TABLE Students 
ADD CONSTRAINT Age CHECK (Age BETWEEN 15 AND 33)
GO

--b Primary key : StudentID of Students, PID of Projects, (StudentID, PID) of StudentProject
ALTER TABLE Students
ADD PRIMARY KEY (StudentID)
GO
ALTER TABLE Projects
ADD PRIMARY KEY (PID) 
GO
ALTER TABLE StudentProject
ALTER COLUMN StudentID INT NOT NULL
ALTER TABLE StudentProject
ALTER COLUMN PID INT NOT NULL
ALTER TABLE StudentProject
ADD PRIMARY KEY (StudentID,PID) 
GO

ALTER TABLE StudentProject
ADD CONSTRAINT Duration DEFAULT (Duration =0)
GO