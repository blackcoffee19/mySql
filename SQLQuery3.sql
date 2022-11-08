USE EmployeeDB

ALTER TABLE Employee
ADD EmpAge int CHECK (EmpAge >18)
GO

ALTER TABLE Employee
ADD EmpAddress varchar(50)
GO

-- Updatae du lieu 2 cot vua them vao cua bang Employee
--cap nhat tuoi 
UPDATE Employee 
SET EmpAge = 17
WHERE EmpName = 'Tuong'
GO
--error

--cap nhat 
UPDATE Employee
SET EmpAge = 25, EmpAddress ='HN'
WHERE EmpName = 'An'
GO

UPDATE Employee
SET EmpAge = 22, EmpAddress ='SG'
WHERE EmpName = 'Tuong'
GO
UPDATE Employee
SET EmpAge = 19, EmpAddress ='DL'
WHERE EmpName = 'Hang'
GO

INSERT INTO Employee (EmpName, EmpGender, EmpID,EmpAge) VALUES('Lam','Female','2','28')
GO
UPDATE Employee SET EmpID = 'E03',DepID=2
WHERE EmpName = 'Lam'
GO
INSERT INTO Employee VALUES('E05','Hai','Male',2,19,'SG')
GO


--Liet ke ten , gioi tinh, tuoi cua cac nhan vien
SELECT EmpName, EmpAge, EmpGender
FROM Employee
GO

--Liet ke cac thuoc tinh xuat ra cung 1 cot
--CONVERT(varchar(50), EmpAge): ham chuyen kieu int thanh kieu chuoi
SELECT EmpName + ':' +CONVERT(varchar(50),EmpAge) + '->'+EmpGender
FROM Employee
GO

--alias > thay ten tap ket quar dau ra (dung AS hoac khong deu dc)
SELECT EmpName AS Name, EmpAge Age, EmpGender Gender
FROM Employee
GO

--computed value: cot tinh toan tu 1 cot khac

SELECT EmpName, EmpAge, EmpAge+1 AS NextAge
FROM Employee
GO

--liet ke dia chi cua cac nhan vien
SELECT EmpAddress
FROM Employee
GO

--DISTINCT: loai bo dong bi trung
SELECT DISTINCT EmpAddress
FROM Employee
GO

--TOP: hien thi 2 nhan vien trong danh sach nhan vien
SELECT TOP 2*
FROM Employee
GO

--TOP PERCENT: hien thi 30% so nhan vien trong ds nhan vien
SELECT TOP 30 PERCENT *
FROM Employee
GO

--liet ke casc nhan vien sap xep theo tuoi tu cao den thap (Mac dinh tu thap den cao: ASC)
SELECT *
FROM Employee
ORDER BY EmpAge DESC
GO

--Cho biet nhan vien nao co tuoi thap nhat
SELECT TOP 1*
FROM Employee
ORDER BY EmpAge
GO

--TOP WITH TIES: neu  nhu co nhieu nguoi cung tuoi thap nhat thi liet ke het
SELECT TOP 1 WITH TIES *
FROM Employee
ORDER BY EmpAge
GO

--cho biet nhan vien nao duoi 20
SELECT * FROM Employee WHERE EmpAge <20
GO
--CHO biet nhan vien nao khac 20
SELECT * FROM Employee WHERE EmpAge <>20 
GO
--Cho biet nhan vien nao bang 20 tuoi
SELECT * FROM Employee WHERE EmpAge=20 
GO
--SELECT WITH INTO: tao ra 1 bang moi va lay du lieu tu bang cu qua
SELECT EmpName, EmpGender, EmpAge INTO NewEmployee
FROM Employee
GO


-- LIKE : cho biet  thong tin cua nhan vien 
SELECT * FROM Employee
WHERE EmpName = 'Tuong'
GO
SELECT * FROM Employee
WHERE EmpName LIKE 'Tuong'
GO

--Cho biet thong tin nhan vien ma ten chua cum tu 'an'
SELECT * FROM Employee
WHERE EmpName LIKE '_an_'
GO
SELECT * FROM Employee
WHERE EmpName LIKE '%an%'
GO

--CHO biet thong tin nhan vien An hoac Tuong

SELECT * FROM Employee
WHERE EmpName = 'Tuong' OR EmpName = 'An'
GO
SELECT * FROM Employee
WHERE EmpName IN('Tuong','An')
GO

--BETWEEN: cho biet nhan vien trong do tuoi tu 19 den 20 tuoi
SELECT * FROM Employee
WHERE EmpAge BETWEEN 19 AND 20
GO

--aggregate : COUNT(), MIN(),MAX(),AVG(),SUM()
--CHo biet co bao nhieu nhan vien trong ds
SELECT COUNT(*) Soluong
FROM Employee
GO
SELECT COUNT(EmpAddress) Soluongdiachi
FROM Employee
GO
SELECT COUNT(DISTINCT EmpAddress) sotinh
FROM Employee
GO

--Cho biet tuoi nho nhat
SELECT MIN(EmpAge) FROM Employee 
GO

--Cho biet tuoi lon nhat
SELECT MAX(EmpAge) FROM Employee
GO
--Cho biet tuoi tung binh
SELECT AVG(EmpAge) FROM Employee
GO
--Cho biet tong tuoi cua nhan vien
SELECT SUM(EmpAge) FROM Employee
GO
--Cho biet ten nhan vien nao chua cung cap dia chi
SELECT EmpName
FROM Employee
WHERE EmpAddress IS NULL
GO

SELECT COUNT(EmpAddress)
FROM Employee
WHERE EmpAddress = 'SG'
GO
--Thong ke so luong nhan vien o moi tinh
SELECT EmpAddress, COUNT(*) soluong
FROM Employee
GROUP BY EmpAddress
GO

UPDATE Employee
SET EmpAddress ='HN'
WHERE EmpName = 'An'
GO
--Liet ke tat ca
SELECT * FROM Employee