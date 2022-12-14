CREATE DATABASE dbPreTest1
GO

USE dbPreTest1
CREATE TABLE tbRoom
(
    RoomNo INT PRIMARY KEY,
    Type VARCHAR(20) CHECK(Type='VIP'OR Type='Single'),
    UnitPrice MONEY CHECK(UnitPrice>=0 AND UnitPrice<1000)
)
GO
CREATE TABLE tbBooking
(
    BookingNo INT,
    RoomNo INT FOREIGN KEY REFERENCES tbRoom(RoomNo),
    TouristName VARCHAR(20) NOT NULL,
    DateFrom DATETIME,
    DateTo DATETIME,
    PRIMARY KEY(BookingNo, RoomNo)
)
GO
ALTER TABLE tbBooking
ADD CONSTRAINT DateTo CHECK(DateTo > DateFrom)
GO
ALTER TABLE dbo.tbRoom 
DROP CONSTRAINT CK__tbRoom__Type__24927208

ALTER TABLE dbo.tbRoom 
ADD CONSTRAINT CK_Type CHECK(Type='VIP'OR Type='Single' OR Type='Double')

INSERT INTO tbRoom VALUES (101, 'Single',100),
						(102, 'Single',100),
						(103, 'Double',250),
						(201, 'Double',250),
						(202, 'Double',300),
						(203, 'Single',150),
						(301, 'VIP',900)
GO
SELECT * FROM tbRoom
set dateformat dmy
INSERT INTO tbBooking VALUES(1,101,'Julia','12/11/2020','14/11/2020'),
							(1,103,'Julia','12/12/2020','13/12/2020'),
							(2,301,'Bill','10/01/2021','14/01/2021'),
							(3,201,'Ana','12/01/2021','14/01/2021'),
							(3,202,'Ana','12/01/2021','14/01/2021')
GO
USE dbPreTest1
SELECT * FROM tbBooking
--5 
CREATE VIEW vwBooking 
WITH SCHEMABINDING
AS
	SELECT B.BookingNo,B.TouristName,B.RoomNo,R.Type,R.UnitPrice,B.DateFrom,B.DateTo
	FROM dbo.tbRoom R JOIN dbo.tbBooking B ON R.RoomNo = B.RoomNo
	WHERE YEAR(B.DateFrom) = 2020
GO

SELECT * FROM vwBooking

--6 
CREATE PROC uspPriceDecrease @sales FLOAT = NULL
AS
	IF @sales IS NULL
	BEGIN 
		SELECT * FROM tbRoom 
		ORDER BY UnitPrice
	END 
	ELSE 
	BEGIN
		UPDATE tbRoom
		SET UnitPrice = UnitPrice - @sales
	END
GO

SELECT * FROM tbRoom
EXEC uspPriceDecrease 
GO
EXEC uspPriceDecrease 10.5
GO

--7.
CREATE PROC uspSpecificPriceIncrease @room VARCHAR(20), @increase FLOAT, @count INT OUTPUT
AS 
	UPDATE tbRoom
	SET UnitPrice = UnitPrice + @increase
	WHERE Type = @room AND UnitPrice>250 
	SELECT @count = @@ROWCOUNT
	
GO
SELECT * FROM tbRoom
DECLARE @count INT
EXEC uspSpecificPriceIncrease 'Single',50,@count OUTPUT
PRINT 'So phong Single tang them 50 la '+CONVERT(VARCHAR(50),@count);

DECLARE @count2 INT
EXEC uspSpecificPriceIncrease 'VIP',50,@count2 OUTPUT
PRINT 'So phong Single tang them 50 la '+CONVERT(VARCHAR(50),@count2);

DECLARE @count3 INT
EXEC uspSpecificPriceIncrease 'Double',50,@count3 OUTPUT
PRINT 'So phong Single tang them 50 la '+CONVERT(VARCHAR(50),@count3);

CREATE PROC uspPriceIncrease @sales FLOAT = NULL
AS
	IF @sales IS NULL
	BEGIN 
		SELECT * FROM tbRoom 
		ORDER BY UnitPrice
	END 
	ELSE 
	BEGIN
		UPDATE tbRoom
		SET UnitPrice = UnitPrice + @sales
	END
GO

EXEC uspPriceIncrease 20
EXEC uspPriceIncrease

--8 Create a trigger named tgBookingRoom that allows one booking order having 3 rooms maximum.
SELECT COUNT(BookingNo)
FROM tbBooking 
WHERE BookingNo =1
GROUP BY BookingNo
CREATE TRIGGER tgBookingRoom
ON tbBooking
FOR INSERT
AS 
	IF ((SELECT COUNT(BookingNo) FROM tbBooking 
	WHERE BookingNo IN (SELECT BookingNo FROM inserted)
	GROUP BY BookingNo ) >3)
		BEGIN 
			PRINT 'Khong the dat nhieu hon 3 phong'
			ROLLBACK
		END
GO	
DROP TRIGGER tgBookingRoom
set dateformat dmy
INSERT INTO tbBooking VALUES (1,301,'Julia','12/11/2020','14/11/2020');
GO
INSERT INTO tbBooking VALUES (1,201,'Julia','12/11/2020','14/11/2020');
GO

--9 Create a trigger named tgRoomUpdate that doing the following (using try-catch structure) : If new price is equal to 0 and this room has not existed in tbBooking, then remove it from tbRoom table else display an error message and roll back transaction.

CREATE TRIGGER tgRoomUpdate
ON tbRoom
FOR UPDATE
AS
	IF (SELECT UnitPrice FROM inserted) = 0 
	BEGIN TRY
		IF (SELECT RoomNo FROM inserted) NOT IN (SELECT RoomNo FROM tbBooking)
		BEGIN
			DELETE FROM tbRoom
			WHERE RoomNo =(SELECT RoomNo FROM inserted)
		END
		ELSE
		BEGIN
			PRINT 'Can not set price = 0 when room is booked'
			ROLLBACK
		END
	END TRY
	BEGIN CATCH 
	SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
GO

