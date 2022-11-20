USE master
CREATE DATABASE ASS9
GO
USE ASS9
CREATE TABLE tbGIAOVIEN(
	MaGV VARCHAR(4) PRIMARY KEY NONCLUSTERED,
	TenGV VARCHAR(40)
)
GO

CREATE TABLE tbHOCVIEN (
	MaHV VARCHAR(4) PRIMARY KEY NONCLUSTERED,
	Hoten VARCHAR(40),
	DiaChi VARCHAR(40)
)
GO

CREATE TABLE tbLOPHOC(
	Malop VARCHAR(4) PRIMARY KEY,
	Tenlop VARCHAR(40),
	Siso INT CHECK(Siso BETWEEN 10 AND 20),
	MaGV VARCHAR(4) FOREIGN KEY REFERENCES tbGIAOVIEN(MaGV)
)
GO

CREATE TABLE tbDANGKY (
	MaHV VARCHAR(4) FOREIGN KEY REFERENCES tbHOCVIEN(MaHV),
	Malop VARCHAR(4) FOREIGN KEY REFERENCES tbLOPHOC(Malop),
	NgayDK DATETIME,
	Ghichu VARCHAR(50),
	PRIMARY KEY(MaHV, Malop)
)
GO

INSERT INTO tbGIAOVIEN VALUES('GV01','Nguyen Thi Loan'),
								('GV02','Do Thi Bich Thuy'),
								('GV03','Nguyen Anh Kim'),
								('GV04','Nguyen Van Tai'),
								('GV05','Luong Thi Cam Tu')
GO
INSERT INTO tbHOCVIEN VALUES('SV01','Do Ngoc Cat Tuong','Quan 1'),
							('SV02','Ngu Van Nha','Quan 1'),
							('SV03','Ngu Van LaM','Quan 1'),
							('SV04','Nguyen Van Thanh','Quan 2'),
							('SV05','Mai Thi Thuy','Quan Tan Binh')
GO
INSERT INTO tbLOPHOC VALUES('L001','Lap Trinh Web',20,'GV01'),
							('L002','Tri Tue Nhan Tao',10,'GV04'),
							('L003','Lap Trinh Game',14,'GV02'),
							('L004','Lap Trinh Android',18,'GV03'),
							('L005','An Ninh Mang',15,'GV04'),
							('L006','Quan Ly Co So Du Lieu',20,'GV05')
GO
set dateformat dmy
INSERT INTO tbDANGKY VALUES('SV01','L003','12-12-2021',''),
							('SV03','L003','12-12-2021',''),
							('SV04','L001','20-10-2020','No Hoc Phi 10.000.000 VND'),
							('SV05','L004','01-10-2022','No Hoc Phi 20.220.000 VND'),
							('SV02','L002','01-12-2020','Hoc Bong Toan Phan'),
							('SV01','L002','01-12-2020','')
GO

--3 
CREATE CLUSTERED INDEX idxHV ON tbHOCVIEN(Hoten)
GO

CREATE CLUSTERED INDEX idxGV ON tbGIAOVIEN(TenGV)
GO

--4
INSERT INTO tbHOCVIEN VALUES('SV06','Le Thu Thao','Quan Tan Phu'),
							('SV07','Nguyen Thu','Quan 8'),
							('SV08','Le Mai','Quan 12'),
							('SV09','Le Van Manh','Quan 2')
GO
-- Hoc vien co ten bat dau bang 'L'
SELECT * FROM tbHOCVIEN
WHERE Hoten LIKE 'L%'
GO

--5 Hoc vien dang ky 2 lop tro len
SELECT DK.MaHV, HV.Hoten,COUNT(*) SoLopDK
FROM tbDANGKY DK INNER JOIN tbHOCVIEN HV ON DK.MaHV = HV.MaHV
GROUP BY DK.MaHV, HV.Hoten
HAVING COUNT(*)>1
GO

--6 Tao view so luong hoc vien da dang ky
CREATE VIEW vwLopHoc 
AS
	SELECT LH.Malop, LH.Tenlop, GV.TenGV, COUNT(DK.MaHV) SoHVDaDK 
	FROM tbLOPHOC LH INNER JOIN tbGIAOVIEN GV ON LH.MaGV= GV.MaGV
	INNER JOIN tbDANGKY DK ON LH.Malop = DK.Malop
	GROUP BY LH.Malop,LH.Tenlop,GV.TenGV
GO
SELECT * FROM vwLopHoc

--7 tao Store procedure nhan tham so ho ten cua gv va liet ke thong tin ve cac lop ma giao vien nay dang day
CREATE PROC uspGV @gv VARCHAR(40)
AS 
	SELECT GV.MaGV, TenGV,L.Malop, L.Tenlop,L.Siso 
	FROM tbGIAOVIEN GV INNER JOIN tbLOPHOC L ON GV.MaGV = L.MaGV
	WHERE TenGV = @gv
GO
EXEC uspGV 'Nguyen Thi Loan'

--8 tao insert update trigger dam bao 1 hv duoc dang ky toi da 2 lop
CREATE TRIGGER trDangky
ON tbDANGKY
FOR INSERT
AS 
	IF (SELECT COUNT(*) FROM tbDANGKY
		WHERE MaHV = (SELECT MaHV FROM inserted))>2
	BEGIN 
		PRINT 'Hoc vien khong the dang ky qua 2 lop'
		ROLLBACK
	END
GO
CREATE TRIGGER trDangky_UpDATE
ON tbDANGKY
FOR UPDATE
AS 
	IF (SELECT COUNT(*) FROM tbDANGKY
		WHERE MaHV = (SELECT MaHV FROM inserted))>2
	BEGIN 
		PRINT 'Hoc vien khong the dang ky qua 2 lop'
		ROLLBACK
	END
GO

INSERT INTO tbDANGKY VALUES('SV01','L005',GETDATE(),'')
UPDATE tbDANGKY 
SET MaHV = 'SV01'
WHERE NgayDK ='01-10-2022'

UPDATE tbDANGKY 
SET MaHV = 'SV04'
WHERE NgayDK ='01-10-2022'
SELECT * FROM tbDANGKY
--9 Tao update trigger khong cho phep doi ten hoc vien 
CREATE TRIGGER trHVTen 
ON tbHOCVIEN
FOR UPDATE
AS 
	IF UPDATE(Hoten)
	BEGIN 
		PRINT 'Khong the doi ten hoc vien'
		ROLLBACK
	END
GO
DROP TRIGGER trHVTen
SELECT * FROM tbHOCVIEN
UPDATE tbHOCVIEN
SET Hoten = 'Le Thi Thu'
WHERE MaHV = 'SV04'
GO

UPDATE tbHOCVIEN
SET Hoten = 'Ngu Van Lam'
WHERE MaHV = 'SV03'
GO

UPDATE tbHOCVIEN
SET DiaChi= 'Quan 4'
WHERE MaHV = 'SV04'
