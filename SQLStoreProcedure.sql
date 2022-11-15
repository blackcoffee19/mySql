USE StudentDB2
GO
SELECT * FROM tbStudent
--tao 1 thu tuc luu tru ko co tham so 
CREATE PROC uspListStudent
AS
SELECT* FROM tbStudent
GO

--Chay thu tuc luu tru
EXEC uspListStudent
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

--tao 1 thu tuc luu tru co 1 tham so dau vao va 1 tham so dau ra
--cho biet diem trung binh (output) khi biet ten cua 1 sinh vien

CREATE PROCEDURE uspAvgMark @name VARCHAR(50), @avgmark FLOAT OUTPUT
AS
SELECT @avgmark= AVG(mark)
FROM tbMark INNER JOIN tbStudent ON tbMark.student = tbStudent.st_id
WHERE tbStudent.st_name = @name
GO
 DROP PROCEDURE uspAvgMark 
DECLARE @avgmark FLOAT;
EXEC uspAvgMark 'Hang',@avgmark OUTPUT;
PRINT 'Diem TB cua Hang la'+ convert(varchar(50),@avgmark);
GO

--tao 1 thu tuc co 1 tham so dau vao la so tin chi, 1 tham so dau ra la so mon thay doi
--update du lieu: tang so tin chi len them 1 neu so tin chi >= tin chi dau vao
--thong ke co bao nhieu mon bi thay doi

SELECT * FROM tbSubject
GO

CREATE PROC uspIncreaseCredit @p_credit INT, @count INT OUTPUT 
AS
	UPDATE tbSubject
	SET credit = credit +1
	WHERE credit >= @p_credit
	SELECT @count = @@ROWCOUNT
GO

DECLARE @somon INT
EXEC uspIncreaseCredit 3,@somon OUTPUT
PRINT 'So mon thay doi la '+CONVERT(varchar(50),@somon)
GO

--tao 1 thu tuc luu tru liet ke ds sv
--neu ko co tham so thi liet ke tat ca sv
--neu co 1 tham so thi liet ke sv theo tham so do(gender)
CREATE PROC uspListStu @gender VARCHAR(50) =NULL
AS 
	IF @gender IS NULL
		BEGIN 
			SELECT * FROM tbStudent
		END
	ELSE
		BEGIN
		SELECT * FROM tbStudent WHERE gender = @gender
		END
GO
--chay luu tru
EXEC uspListStu 
GO
EXEC uspListStu 'Female'
GO

