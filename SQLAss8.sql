CREATE DATABASE ASS8
USE ASS8
CREATE TABLE tbKhachHang (
	MaKH VARCHAR(3) PRIMARY KEY,
	Hoten VARCHAR(40),
	DiaChi VARCHAR(40)
)
GO

CREATE TABLE tbMatHang(
	MaMH VARCHAR(3) PRIMARY KEY,
	TenMH VARCHAR(40),
	DonViTinh VARCHAR(20),
	DonGia INT
)
GO
ALTER TABLE tbMatHang
ALTER COLUMN DonGia FLOAT
CREATE TABLE tbDonHang(
	MaDH INT IDENTITY(1,1) PRIMARY KEY,
	MaKH VARCHAR(3) FOREIGN KEY REFERENCES tbKhachHang(MaKH),
	NgayDat DATETIME DEFAULT(GETDATE()),
	DaThanhToan INT CHECK(DaThanhToan=0 OR DaThanhToan=1)
)
GO
CREATE TABLE tbCTDonHang(
	MaDH INT FOREIGN KEY REFERENCES tbDonHang(MaDH),
	MaMH VARCHAR(3) FOREIGN KEY REFERENCES tbMatHang(MaMH),
	SoLuong INT
)
GO
set dateformat dmy

INSERT INTO tbKhachHang VALUES ('C01','An An','Nguyen Hue'),
								('C02','Bao Bao','Pham Ngu Lao'),
								('C03','Ky Ky','Le Loi')
GO
INSERT INTO tbMatHang VALUES ('P01','Coca Cola','Lon',2),
								('P02','Chocolate Cake','Cái',5),
								('P03','Kẹo dẽo','Gói',3),
								('P04','Đường','Kg',1.5),
								('P05','Sữa','Lon',20)
GO

INSERT INTO tbDonHang (MaKH,NgayDat,DaThanhToan) VALUES ('C01','15/10/2014',1),
														('C01','17/10/2014',0),
														('C02','12/11/2014',1),
														('C03','14/11/2014',0),
														('C02','10/10/2014',0)
GO

INSERT INTO tbCTDonHang VALUES (1,'P02',5),
								(1,'P03',1),
								(2,'P01',10),
								(3,'P05',2),
								(3,'P04',2),
								(3,'P03',1),
								(4,'P03',2),
								(5,'P01',12),
								(5,'P03',3)
GO

--b  Hiển thị các Don Hang đã quá 1 năm so với ngày hiện hành
SELECT *
FROM tbDonHang 
WHERE DATEDIFF(day,NgayDat,GETDATE())>DAY(365)
GO

--c  Xác định tên mặt hàng nào được đặt mua nhiều lần nhất 
SELECT TOP 1 MH.TenMH, COUNT(*)
FROM tbCTDonHang CT INNER JOIN tbDonHang DH ON CT.MaDH = DH.MaDH
					INNER JOIN tbMatHang MH ON CT.MaMH = MH.MaMH
GROUP BY MH.TenMH
ORDER BY COUNT(*) DESC

--d Tạo view vwDH để liệt kê các DON HANG chưa thanh toán trên 30 ngày so với ngày hiện hành 
CREATE VIEW vwDH 
AS
SELECT * FROM tbDonHang 
WHERE DaThanhToan = 0 AND DATEDIFF(day,NgayDat,GETDATE()) > DAY(30)
GO
SELECT * FROM vwDH

--e Tạo 1 Stored procedure uspKH nhận tham số input @hoten là tên khách hàng, liệt kê chi tiết các thông tin về các đơn hàng của khách hàng này.
CREATE PROC uspKH @hoten VARCHAR(40)
AS
	SELECT KH.MaKH,KH.Hoten,DH.MaDH,CT.MaMH,MH.TenMH, CT.SoLuong,MH.DonGia,MH.DonViTinh
	FROM tbDonHang DH JOIN tbKhachHang KH ON DH.MaKH = KH.MaKH
						JOIN tbCTDonHang CT ON DH.MaDH = CT.MaDH
						JOIN tbMatHang MH ON CT.MaMH = MH.MaMH
	WHERE KH.Hoten = @hoten
GO
EXEC uspKH 'An An'
GO

--f Tạo stored procedure uspMH tăng giá tất cả các mặt hàng lên 10%.
ALTER PROC uspMH
AS 
	UPDATE tbMatHang
	SET DonGia = DonGia*1.1
GO
EXEC uspMH
GO
SELECT * FROM tbMatHang
