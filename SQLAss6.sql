CREATE DATABASE Assignment6
USE Assignment6
CREATE TABLE Monhoc(
    MSMH CHAR(4),
    TENMH VARCHAR(40),
    SOTINCHI INT DEFAULT 3,
    TINHCHAT INT CHECK(TINHCHAT=1 OR TINHCHAT=0)
)
GO

CREATE TABLE Lop (
    MALOP CHAR(4),
    TEN VARCHAR(40),
    SISO INT
)
GO
CREATE TABLE Sinhvien(
    MSSV INT IDENTITY(9900270,1) NOT NULL,
    HOTEN VARCHAR(40),
    NGAYSINH DATETIME,
    LOP CHAR(4)
)
GO
DROP TABLE Sinhvien
CREATE TABLE Diem(
    MSSV INT IDENTITY(9900270,1),
    MSMH CHAR(4),
    DIEMTHI FLOAT
)
GO
DROP TABLE Diem


--a tao khoa chinh khoa ngoai
ALTER TABLE Monhoc
ALTER COLUMN MSMH CHAR(4) NOT NULL
GO 

ALTER TABLE Monhoc
ADD CONSTRAINT PK_MSMH PRIMARY KEY (MSMH)

ALTER TABLE Lop
ALTER COLUMN MALOP CHAR(4) NOT NULL
GO 

ALTER TABLE Lop
ADD CONSTRAINT PK_MALOP PRIMARY KEY (MALOP)

ALTER TABLE Sinhvien
DROP COLUMN MSSV

ALTER TABLE Sinhvien
ADD MSSV INT NOT NULL IDENTITY(990027,1)
GO 

ALTER TABLE Sinhvien
ADD CONSTRAINT PK_MSSV PRIMARY KEY (MSSV)
GO
ALTER TABLE Sinhvien
ADD CONSTRAINT FK_LOP FOREIGN KEY (LOP) REFERENCES Lop(MALOP)
GO
ALTER TABLE Diem
DROP COLUMN MSSV
ALTER TABLE Diem 
ADD MSSV INT NOT NULL IDENTITY(9900270,1)
ALTER TABLE Diem 
ALTER COLUMN MSMH CHAR(4) NOT NULL
GO

ALTER TABLE Diem 
ADD CONSTRAINT PK_MSSV2 PRIMARY KEY (MSSV,MSMH)
GO
ALTER TABLE Diem 
DROP CONSTRAINT PK_MSSV2
ALTER TABLE Diem
ADD CONSTRAINT FK_MSSV FOREIGN KEY (MSSV) REFERENCES Sinhvien(MSSV)
GO
ALTER TABLE Diem
ADD CONSTRAINT FK_MSMH2 FOREIGN KEY (MSMH) REFERENCES Monhoc(MSMH)
GO

INSERT INTO Monhoc VALUES('HCJS', 'HTML CSS JavaScript', 4,1),
                        ('AJS', 'AngularJS', 3,1),
                        ('LBEP', 'Logic Building', 3,1),
                        ('DDD', 'Database Design and Development', 2,0),
                        ('DMS', 'Database Management (SQL Server)', 4,1),
                        ('PRJ1', 'eProject', 4,1)
GO
set dateformat dmy
INSERT INTO Lop VALUES('T1M2','Web Development',22),
                        ('T1M3','Application Development',15),
                        ('T5M2','PHP',19),
                        ('T6M1','Database Management',26),
                        ('T5M1','PHP',20)
GO
INSERT INTO Sinhvien (HOTEN,NGAYSINH,LOP) VALUES('Nguyen Van A','01/04/2001','T1M2'),
                                                        ('Nguyen Thi Binh','02/09/1999','T1M3'),
                                                        ('Do Minh Thu ','01/12/1996','T5M2'),
                                                        ('Nguyen Thi Thuy','10/11/1998','T6M1'),
                                                        ('Duong Thi Mai Chau','01/01/2002','T6M1'),
                                                        ('Vo Van Tam','24/04/1990','T1M3')
GO
SELECT * FROM Sinhvien
SELECT * FROM Monhoc
SET IDENTITY_INSERT Diem ON
INSERT INTO Diem (MSMH,MSSV,DIEMTHI) VALUES('AJS',9900275,50.4),
                        ('HCJS',9900274,80.5),
                        ('AJS',9900271,90.6),
                        ('AJS',9900273,40.9),
                        ('HCJS',9900273,60.0),
                        ('DMS',9900271,53.6),
                        ('DMS',9900272,20.0),
                        ('AJS',9900272,30.0),
                        ('HCJS',9900272,56.8),
                        ('LBEP',9900275,65.6),
                        ('LBEP',9900272,45.5),
                        ('LBEP',9900274,90.5),
                        ('LBEP',9900273,70.0),
                        ('PRJ1',9900275,70.0),
                        ('PRJ1',9900271,65.2),
                        ('PRJ1',9900273,22.2),
                        ('PRJ1',9900272,40.0),
                        ('PRJ1',9900274,80.0),
                        ('DMS',9900275,79.0),
                        ('DMS',9900273,68.0)
GO
ALTER TABLE Sinhvien 
ADD GIOITINH CHAR(1) CHECK(GIOITINH='F' OR GIOITINH='M')
GO

UPDATE  Sinhvien
SET GIOITINH = 'F'
WHERE MSSV=9900271
GO

UPDATE  Sinhvien
SET GIOITINH = 'F'
WHERE MSSV=9900272
GO
UPDATE  Sinhvien
SET GIOITINH = 'F'
WHERE MSSV=9900273
GO
UPDATE  Sinhvien
SET GIOITINH = 'F'
WHERE MSSV=9900274
GO
UPDATE  Sinhvien
SET GIOITINH = 'M'
WHERE MSSV=9900270
GO
UPDATE  Sinhvien
SET GIOITINH = 'M'
WHERE MSSV=9900275
GO

--C
SELECT TOP 1 WITH TIES * 
FROM Monhoc
ORDER BY SOTINCHI DESC
--D
SELECT SV.MSSV, HOTEN,LOP, D.MSMH ,D.DIEMTHI
FROM Sinhvien SV INNER JOIN Diem D ON SV.MSSV = D.MSSV
WHERE D.MSMH = 'DMS'
GO
--E
SELECT TOP 1 WITH TIES SV.MSSV, HOTEN,LOP, D.MSMH ,D.DIEMTHI
FROM Sinhvien SV INNER JOIN Diem D ON SV.MSSV = D.MSSV
WHERE D.MSMH = 'DMS'
ORDER BY DIEMTHI DESC
GO

--F 
SELECT *
FROM Diem
WHERE MSSV = 9900275

--G 
SELECT DISTINCT Diem.MSSV, Sinhvien.HOTEN, Sinhvien.LOP,AVG(DIEMTHI)
FROM Sinhvien JOIN Diem ON Sinhvien.MSSV = Diem.MSSV
GROUP BY Diem.MSSV,Sinhvien.HOTEN,Sinhvien.LOP 
HAVING AVG(DIEMTHI) <=50
GO

--h
SELECT DISTINCT Diem.MSSV, Sinhvien.HOTEN, Sinhvien.LOP,AVG(DIEMTHI)
FROM Sinhvien JOIN Diem ON Sinhvien.MSSV = Diem.MSSV
GROUP BY Diem.MSSV,Sinhvien.HOTEN,Sinhvien.LOP
ORDER BY MSSV,LOP, HOTEN
GO

--I
SELECT D.MSSV, SV.HOTEN, SV.LOP, D.MSMH, D.DIEMTHI
FROM Diem D INNER JOIN Sinhvien SV ON D.MSSV=SV.MSSV
INNER JOIN Monhoc M ON D.MSMH = M.MSMH
ORDER BY D.MSMH