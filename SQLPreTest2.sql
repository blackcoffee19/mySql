CREATE DATABASE Pretest2DB
ON PRIMARY 
(NAME='Pretest2DB',FILENAME='pretest2.mdf',
SIZE=5MB,MAXSIZE=50MB,FILEGROWTH=10%),
FILEGROUP GroupData
(NAME='GroupData',FILENAME='pretest2b.ndf',
SIZE=10MB,MAXSIZE=unlimited,FILEGROWTH=5MB)
LOG ON (NAME='pretest2_log',FILENAME='pretest2_log.ldf',
SIZE=2MB,MAXSIZE=unlimited,FILEGROWTH=10%)
GO

CREATE TABLE tbFlight (
    AircraftCode VARCHAR(10) PRIMARY KEY,
    FType VARCHAR(10) CHECK(FType='Boeing'OR FType='AirBus'),
    Source VARCHAR(20),
    Destination VARCHAR(20),
    DepTime DATETIME,
    JourneyHrs INT CHECK(JourneyHrs BETWEEN 1 AND 20)
)
GO
INSERT INTO tbFlight VALUES('UA01','Boeing', 'Los Angeles','London',15.3,6),
                            ('UA02','Boeing', 'California','New York',9.3,8),
                            ('SA01','Airbus', 'Istanbul','Ankara',11.15,8),
                            ('SAO2','Airbus', 'London','Moscow',11.15,9),
                            ('SQ01','Airbus', 'Sydney','Ankara',1.45,15),
                            ('SQ02','Boeing', 'Perth','Aden',13.3,10),
                            ('SQ03','Airbus', 'San Francisco','Nairobi',15.45,15)
GO

--5 Write a query to display the flights that have journey hours less than 9.
SELECT * 
FROM tbFlight
WHERE JourneyHrs < 9
--6 Create a view vwBoeing which contains flights that have Boeing aircrafts.
--Note: this view will need to check for domain integrity.
CREATE VIEW vwBoeing 
AS 
    SELECT *
    FROM tbFlight
    WHERE FType = 'Boeing'
GO
SELECT * FROM vwBoeing
GO  

--7. Create a store procedure uspChangeHour to increase journey hours by a given value (input parameter)
CREATE PROCEDURE uspChangeHour @hour INT
AS 
    UPDATE tbFlight
    SET JourneyHrs = JourneyHrs+@hour

GO
SELECT AircraftCode, JourneyHrs FROM tbFlight
EXEC uspChangeHour 4

--8 Create a trigger tgFlightInsert for table tbFlight which will perform rollback transaction
-- if a new record has the source same as the destination and display appropriate error message
