CREATE DATABASE StudentDB2
GO 
USE StudentDB2

CREATE TABLE tbStudent
(
	st_id varchar(50) PRIMARY KEY NOT NULL,
	st_name varchar(50),
	dob datetime,
	gender varchar(50) CHECK (gender='Female' OR gender='Male'),
	mentor varchar(50) FOREIGN KEY REFERENCES tbStudent(st_id)
)
GO

CREATE TABLE tbSubject
(
	sb_id varchar(50) PRIMARY KEY NOT NULL,
	sb_name varchar(50),
	credit int
)
GO

CREATE TABLE tbMark
(
	student varchar(50) FOREIGN KEY REFERENCES tbStudent(st_id),
	subject varchar(50) FOREIGN KEY REFERENCES tbSubject(sb_id),
	mark FLOAT
)
GO

set dateformat dmy
INSERT INTO tbStudent VALUES('SV01','Hang','14-02-2003','Female',NULL),
							('SV02','Vinh','14-02-1994','Male','SV01'),
							('SV03','Huy','17/11/2003','Male','SV01'),
							('SV04','Truong','14-10-2003','Male','SV01'),
							('SV05','Tuong','01-09-2000','Female',NULL),
							('SV06','Quang Huy','02-10-2002','Male','SV05')
GO

INSERT INTO tbSubject VALUES('SB01','C',4),('SB02','HCJS',5),('SB03','AJS',2)
GO

INSERT INTO tbMark VALUES ('SV01','SB01',60),
('SV01','SB01',90),
('SV01','SB02',90),
('SV01','SB03',85),
('SV02','SB01',100),
('SV02','SB02',100),
('SV03','SB01',85),
('SV04','SB01',55),
('SV05','SB02',95),
('SV05','SB03',95)
GO

--TRUY VAN DU LIEU
-- cho biet diem trung binh cua moi sinh vien
SELECT student, AVG(mark) DIEM_TB
FROM tbMark
GROUP BY student
GO
-- cho biet diem trung binh cua moi mon hoc
SELECT subject, AVG(mark) DIEM_TB
FROM tbMark
GROUP BY subject
GO
--Cho biet diem trung binh moi mon cua moi sinh vien
SELECT student, subject, AVG(mark) DIEM_TB
FROM tbMark
GROUP BY subject,student
GO

SELECT AVG(mark) AS DIEMTB
FROM tbMark
GO

--ROLLUP
SELECT student,subject , AVG(mark) DIEM_TB
FROM tbMark
GROUP BY student,subject WITH ROLLUP
GO

--CUBE
SELECT student,subject, AVG(mark) DIEM_TB
FROM tbMark
GROUP BY student,subject WITH CUBE
GO

--Cho biet so lan thi moi mon cua moi sinh vien
SELECT student, subject, COUNT(*) SO_LAN_THI
FROM tbMark
GROUP BY student,subject
GO
--Cho biet sinh vien nao co so lan thi >=2
SELECT student, subject, COUNT(*) SO_LAN_THI
FROM tbMark
GROUP BY student,subject
HAVING COUNT(*)>=2
GO

--CHo biet sinh vien nao co diem thi = 95
SELECT DISTINCT student, mark
FROM tbMark
WHERE mark=95
GO

--Cho biet sv nao co diem thi bang diem thi cao nhat cua ca lop
SELECT DISTINCT student, mark
FROM tbMark
WHERE mark = (SELECT MAX(mark) FROM tbMark)
GO

--Cho biet ten cua sinh vien co diem thi
--C1 IN
SELECT st_name
FROM tbStudent
WHERE st_id IN(SELECT student FROM tbMark)
GO

--C2 EXISTS
SELECT st_name
FROM tbStudent
WHERE EXISTS (SELECT student FROM tbMark WHERE tbMark.student = tbStudent.st_id)
GO

--C3
SELECT DISTINCT st_name
FROM tbStudent, tbMark
WHERE tbStudent.st_id = tbMark.student
GO

--Cho biet sinh vien nao khong co diem mon nao
--C1 IN
SELECT st_name
FROM tbStudent
WHERE st_id NOT IN(SELECT student FROM tbMark)
GO

--C2 EXISTS
SELECT st_name
FROM tbStudent
WHERE NOT EXISTS (SELECT student FROM tbMark WHERE tbMark.student = tbStudent.st_id)
GO

--Liet ke ten cua sinh vien co thi mon HCJS
SELECT st_name
FROM tbStudent, tbMark, tbSubject
WHERE tbStudent.st_id = tbMark.student
AND tbMark.subject = tbSubject.sb_id
AND sb_name = 'HCJS'
GO

--Cho biet tuoi cua cac sinh vien
SELECT st_name, DATEDIFF(year, dob,GETDATE()) age
FROM tbStudent
GO

--Xuat ra nam hien tai
SELECT YEAR(GETDATE())
GO

--Xuat ra thang hien tai
SELECT MONTH(GETDATE())
GO

--Xuat ra ngay hien tai
SELECT DAY(GETDATE())
GO

--INNER JOIN ~ JOIN
--Liet ke ten sinh vien, ten mon hoc, diem
SELECT st_name, sb_name, mark
FROM tbMark JOIN tbStudent ON tbMark.student = tbStudent.st_id
			JOIN tbSubject ON tbMark.subject = tbSubject.sb_id
GO

--ALIAS
SELECT st_name, sb_name, mark
FROM tbMark M JOIN tbStudent S ON M.student = S.st_id
			JOIN tbSubject ON M.subject = tbSubject.sb_id
GO

--LeFT JOIN
SELECT st_name, mark
FROM tbStudent S LEFT JOIN tbMark M ON S.st_id = M.student
GO
SELECT st_name, mark
FROM tbMark M LEFT JOIN tbStudent S ON S.st_id = M.student
GO

--SV nao khong thi
SELECT st_name, mark
FROM tbStudent S LEFT JOIN tbMark M ON S.st_id = M.student
WHERE mark IS NULL
GO

--Self join: hay cho biet ten mentor cua cac sinh vien
SELECT S1.st_name tenSV, S2.st_name tenMentor
FROM tbStudent S1 JOIN tbStudent S2 ON S1.mentor= S2.st_id
GO

--UNION
SELECT st_id
FROM tbStudent
UNION
SELECT student
FROM tbMark
GO

--INTERSECT
SELECT st_id
FROM tbStudent
INTERSECT
SELECT student
FROM tbMark
GO

--EXCEPT: Cho biet sv nao ko thi
SELECT st_id
FROM tbStudent
EXCEPT
SELECT student
FROM tbMark
GO

--SELECT * FROM Sales_Order
--PIVOT (SUM(Quantity) FOR Product IN ([Laptop][IPhone])) AS PrivotedOrder;
--UNPIVOT (Quantity FOR Product IN ([Laptop],[IPhone])) AS UnPVT;