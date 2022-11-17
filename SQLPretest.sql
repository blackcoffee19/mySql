CREATE DATABASE PretestDB 
GO

CREATE TABLE tbCustomer(
    CustCode VARCHAR(5) PRIMARY KEY,
    CustName VARCHAR(30) NOT NULL,
    CustAddress VARCHAR(50) NOT NULL,
    CustPhone VARCHAR(15),
    CustEmail VARCHAR(25),
    CustStatus VARCHAR(10) CHECK(CustStatus='Valid' OR CustStatus='Invalid') DEFAULT('Valid')
)
GO

CREATE TABLE tbMessage(
    MsgNo INT IDENTITY(1000,1) PRIMARY KEY,
    CustCode VARCHAR(5) FOREIGN KEY REFERENCES tbCustomer(CustCode),
    MsgDetails VARCHAR(300) NOT NULL,
    MsgDate DATETIME NOT NULL DEFAULT(GETDATE()),
    Status VARCHAR(10) CHECK (Status='Pending' OR Status='Resolved')
)
GO

INSERT INTO tbCustomer VALUES('C001','Rahul Khana','7th Cross Road', '298345878','khannar@hotmail.com','Valid'),
                                ('C002','Anil Thakkar','Line Ali Road', '657654323','Thakkar2002@yahoo.com','Valid'),
                                ('C004','Sanjay Gupta','Link Road', '367654323','SanjayG@indiatimes.com','Invalid'),
                                ('C005','Sagar Vyas','Link Road', '376543255','Sagarvyas@india.com','Valid')
GO

set dateformat dmy
INSERT INTO tbMessage (CustCode,MsgDetails,MsgDate,Status) VALUES ('C001','Voice mail always give ACCESS DENIED message','31-08-2017','Pending'),
                                                                    ('C005','Voice mail always give NO ACCESS message','01-09-2017','Pending'),
                                                                    ('C001','Please send all future bill to residential address instead of my office address','05-09-2017','Resolved'),
                                                                    ('C004','Please send new monthly brochure ... ','08-11-2017','Pending')
GO

--5 
SELECT * 
FROM tbCustomer
WHERE CustCode NOT IN (SELECT DISTINCT CustCode FROM tbMessage)
GO

--6 
CREATE VIEW vwReport 
AS
    SELECT MsgNo, MsgDetails,MsgDate AS DatePosted, C.CustName PostedBy, [Status]  
    FROM tbMessage M INNER JOIN tbCustomer C ON M.CustCode=C.CustCode
    WHERE MsgDate>'01-09-2017'
GO
SELECT * FROM vwReport

--7 
CREATE PROC uspCountStatus @status VARCHAR(10), @count INT OUTPUT
AS
    SELECT @count = COUNT(*)
    FROM tbMessage
    WHERE [Status] = @status
GO

DECLARE @num INT;
EXEC uspCountStatus 'Pending', @num OUTPUT;
PRINT 'So tin nhan trong trang thai Pending = '+CONVERT(VARCHAR(20),@num);
