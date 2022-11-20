--tao 1 trigger INSERT
--ko cho nhap diem ma >100

CREATE TRIGGER triggerCheckMark
ON tbMark
FOR INSERT 
AS
	IF(SELECT mark FROM inserted)>100
		BEGIN
			PRINT 'Cannot insert mark > 100'
			ROLLBACK
		END
GO

--test trigger
--insert ko thanh cong
INSERT INTO tbMark VALUES('SV05','SB03',110)
GO
INSERT INTO tbMark VALUES('SV05','SB03',100)
GO
SELECT * FROM tbMark

--TAO 1 trigger INSERT
--ko cho phep moi sinh vien thi 1 mon qua 2 lan
CREATE PROC timeExam @id VARCHAR(4),@sub VARCHAR(4), @time INT OUTPUT
AS 
	SELECT @time = COUNT(*)
	FROM tbMark
	WHERE student = @id AND subject = @sub
	GROUP BY subject,student
GO
DROP PROC timeExam
DECLARE @time INT;
EXEC timeExam 'SV01','SB01',@time OUTPUT
PRINT 'So lan thi laf '+CONVERT(VARCHAR(10),@time);
GO
GO
CREATE TRIGGER triggerCheckMark
ON tbMark
FOR INSERT 
AS
	
	IF(SELECT COUNT(*) FROM tbMark
	WHERE student = (SELECT student FROM inserted) AND 
	subject = (SELECT subject FROM inserted))>2
		BEGIN
			PRINT 'Cannot insert'
			ROLLBACK
		END
GO
DROP TRIGGER triggerCheckMark
INSERT INTO tbMark VALUES('SV01','SB01',32); --ko thanh cong
INSERT INTO tbMark VALUES('SV02','SB01',100); -- thanh cong


--tao 1 trigger moi ko cho update diem cua sinh vien
CREATE TRIGGER trigger_UpdateMark
ON tbMark
FOR UPDATE
AS 
	IF UPDATE(mark)
		BEGIN
			PRINT 'CAnnot update Mark'
			ROLLBACK
		END
GO

UPDATE tbMark
SET mark = 100
WHERE student ='SV04'
GO
set dateformat dmy
SELECT * FROM tbStudent
--tao 1 trigger ko cho update ngay sinh lon hon ngay hien tai
CREATE TRIGGER trigger_UpdateDOB
ON tbStudent
FOR UPDATE
AS 
	IF(SELECT dob FROM inserted) > GETDATE()
	BEGIN
	PRINT 'Ngay sinh phai nho hon ngay hien hanh'
	ROLLBACK
	END
GO

UPDATE tbStudent
SET dob ='18-12-2022'
WHERE st_id = 'SV04'
GO

--tao 1 trigger delete
--ko cho phep delete sv Hang

CREATE TRIGGER trigger_DeleteStudent
ON tbStudent
FOR DELETE
AS 
	IF 'Hang' IN (SELECT st_name FROM deleted)
	BEGIN 
		PRINT 'Cannot delete this student'
		ROLLBACK
	END
GO

DELETE tbStudent
WHERE st_id = 'SV01'
GO
DELETE tbStudent
WHERE st_id='SV05' --Error
--tao 1 trigger delete, cho phep xoa ban 'Tuong'
CREATE TRIGGER trigger_AcceptDelete
ON tbStudent
INSTEAD OF DELETE
AS 
	DELETE tbMark WHERE student = (SELECT st_id FROM deleted)
	DELETE tbStudent WHERE st_name = (SELECT st_name FROM deleted)
	PRINT 'Deleted'
GO
DROP TRIGGER trigger_AcceptDelete
SELECT * FROM tbStudent

DELETE tbStudent
WHERE st_id='SV02'
GO