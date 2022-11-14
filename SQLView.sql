--Tao view 
USE StudentDB2
CREATE VIEW vwStudentGirl1
AS
SELECT * FROM tbStudent
WHERE gender = 'Female'
GO
--Xem du lieu trong view vwStudentGirl1
SELECT * FROM vwStudentGirl1
GO


-- Tao view StudentMark tu 3 bang co so
CREATE VIEW vwStudentMark
AS 
SELECT st_id, st_name, sb_name, mark
FROM tbMark M JOIN tbStudent S ON M.student = S.st_id
JOIN tbSubject SB ON M.subject = SB.sb_id
GO

--xem du lieu cua view vwStudentMark
SELECT * FROM vwStudentMark
GO

--tao view luu tru thong tin cua 3 sinh vien co diem cao nhat
CREATE VIEW vwHighestMark
AS
SELECT TOP 3 *
FROM tbMark
ORDER BY mark DESC
GO
SELECT * FROM vwHighestMark
--liet ke tat ca sinh vien co diem tu cao xuong thap
CREATE VIEW vwHighMark
AS SELECT TOP 100 *
FROM tbMark
ORDER BY mark DESC
GO
--Xem view 
SELECT * FROM vwHighMark
GO

--Xu ly du lieu tren View
--Doi voi view tao tu 1 bang vwStudentGirl
--insert du lieu vao view
INSERT INTO vwStudentGirl1 VALUES('SV07','Lan','2005-02-10','Female','SV01')
GO

--kiem tra du lieu trong view
SELECT * FROM vwStudentGirl1
GO

--Kiem tra du lieuj vao bang co so -> da them vao
SELECT * FROM tbStudent
GO

--Nguoc lai them du lieu vao bang co so -> co them vao view hay ko?
INSERT INTO tbStudent VALUES ('SV08','Tri','1992-09-04','Male',NULL);
GO
INSERT INTO tbStudent VALUES ('SV09','Mai','1996-09-06','Female',NULL);
GO

--Kiem tra trong view xem co sv moi ko? -> Co
SELECT * FROM vwStudentGirl1
GO

--view tao tu nhieu bang vwStudentMark
--insert du lieu vao view>>?KO duoc
INSERT INTO vwStudentMark VALUES('SV06','Quang Huy','C',60)
GO

--update du lieu tren view
--view tu 1 bang
UPDATE vwStudentGirl1
SET dob = '1997-09-05'
WHERE st_name='Mai'
GO

--xem du lieu tren view va bang co so
SELECT * FROM vwStudentGirl1
GO
SELECT * FROM tbStudent
GO

--update du lieu tren view 
--view tu 2 bang
UPDATE vwStudentMark
SET mark = 100
WHERE sb_name = 'AJS' AND st_name = 'Tuong'

--xem du lieu tren view va bang co so
SELECT * FROM vwStudentMark
GO
SELECT * FROM tbMark
GO

--delete tren view
--view tren 1 bang
DELETE vwStudentGirl1
WHERE st_name = 'Mai'
GO
--xem du lieu tren view va bang co so
SELECT * FROM vwStudentGirl1
GO
SELECT * FROM tbStudent
GO

--view tren 3 bang vwStudentMark -> KO DC
DELETE vwStudentMark
WHERE st_name = 'Tuong' AND sb_name='AJS'
GO

--view vwStudentGirl -> Them sv Boy vao
INSERT INTO vwStudentGirl1 VALUES ('SV10','Vinh','2005-02-10','Male','SV01')
GO
SELECT * FROM vwStudentGirl1
GO
--thay doi cau truc cua view, tao rang buoc ko cho them sv boy vao
ALTER VIEW vwStudentGirl1
AS
SELECT * FROM tbStudent
WHERE gender ='Female'
WITH CHECK OPTION
GO

--them sv la male vao-> Ko them duoc do vi pham rang buoc
INSERT INTO vwStudentGirl1 VALUES ('SV10','An','2005-02-10','Male','SV01')
GO

--with schemabinding: bang co so ko duoc thay doi cau truc khi view tao bang cach nay
--select * ko duoc phai select tung cot mong muon
CREATE VIEW vwSubject
WITH SCHEMABINDING
AS SELECT sb_id, sb_name, credit
FROM dbo.tbSubject
GO

--Thay doi cau truc cua bang co so -> ko duoc 
ALTER TABLE tbSubject
ALTER COLUMN credit FLOAT
GO
