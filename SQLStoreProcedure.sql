USE StudentDB
GO

--tao 1 thu tuc luu tru ko co tham so 
CREATE PROC uspListStudent
AS
SELECT* FROM tbStudent-- Get a list of tables and views in the current database
SELECT table_catalog [database], table_schema [schema], table_name [name], table_type [type]
FROM INFORMATION_SCHEMA.TABLES
GO

--Chay thu tuc luu tru
EXEC uspListStudentup
GO

--tao 1 thu tuc luu tru co 1 tham so dau vao (input paramenter)
--hay cho biet gioi tinh cua sinh vien khi biet ten cua sinh vien do

CREATE PROC uspGender @name VARCHAR(50)
AS 
SELECT * FROM tbStudent
WHERE st_name = @name
GO

--Chay thu tuc luu tru 
EXEC uspGender 'Hang'
GO

EXEC uspGender 'Tri'
GO

CREATE PROC uspMark @name VARCHAR(50), @subject VARCHAR(50)
AS
SELECT mark
FROM tbMark M JOIN tbStudent S ON M.student=S.st_id
JOIN tbSubject SB ON M.subject = SB.st_id
WHERE st_name = @name AND sb_name = @subject
GO

--Chay thu tuc luu tru

EXEC uspMark 'Hang','C'