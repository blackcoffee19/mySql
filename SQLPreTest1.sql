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
ALTER COLUMN DateTo DATETIME CHECK DateTo > DateFrom
GO