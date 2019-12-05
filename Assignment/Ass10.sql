/*
	1. Create a database named Ass10_Db with the following specifications :
	a. Primary file group with the data file Ass10.mdf. The size, maximum size, and file growth should be 5, 50 and 10% respectively.
	b. File group Group1 with the data file Ass10_1.ndf. The size, maximum size, and file growth should be 10, unlimited, and 5 respectively.
	c. Log file Ass10_log.ldf. The size, maximum size, and file growth should be 2, unlimited, and 10% respectively.
*/

CREATE DATABASE dbAss10
ON PRIMARY
(NAME='Ass10',FILENAME='D:\Study\Aptech\Season1\SQL\Database\Ass10.mdf',SIZE=5,MAXSIZE=50,FILEGROWTH=10%),
FILEGROUP MyFileGroup
(NAME='Ass10_1',FILENAME='D:\Study\Aptech\Season1\SQL\Database\Ass10_1.ndf',SIZE=10,MAXSIZE=UNLIMITED,FILEGROWTH=5)
LOG ON
(NAME='Ass10_log',FILENAME='D:\Study\Aptech\Season1\SQL\Database\Ass10_log.ldf',SIZE=2,MAXSIZE=UNLIMITED,FILEGROWTH=10%)
GO 

USE dbAss10
GO 

/*
	2. Create the following tables in the database, applying the specified appropriate integrity constraints
	Note: Ensure CustStatus column in Customer table and Status column in CustomerMessage accept only the specified values
*/

CREATE TABLE tbCustomer
(
	CustCode VARCHAR(5) PRIMARY KEY NONCLUSTERED,   
	CustName VARCHAR(30) NOT NULL ,		
	CustAddress VARCHAR(50) NOT NULL ,	
	CustPhone VARCHAR(15) ,				
	CustEmail VARCHAR(25) , 
	CustStatus VARCHAR(10) DEFAULT 'Valid' CHECK(CustStatus='Valid' OR CustStatus='Invalid')
)
GO 

CREATE TABLE tbMessage
(
	MsgNo INT IDENTITY(1000,1) PRIMARY KEY NONCLUSTERED,
	CustCode VARCHAR(5) FOREIGN KEY REFERENCES dbo.tbCustomer(CustCode) ,
	MsgDetail VARCHAR(300) NOT NULL,
	MsgDate DATE NOT NULL DEFAULT GETDATE() ,
	[Status] VARCHAR(10) CHECK([Status]='Pending' OR [Status]='Resolved')
)
GO 

/*
	3. Insert the following data into the tables:
*/

INSERT dbo.tbCustomer
    (
        CustCode,
        CustName,
        CustAddress,
        CustPhone,
        CustEmail,
        CustStatus
    )
VALUES
    (
        'C001', -- CustCode - varchar(5)
        'Rahul Khana', -- CustName - varchar(30)
        '7th Cross Road', -- CustAddress - varchar(50)
        '298345878', -- CustPhone - varchar(15)
        'khannar@hotmail.com', -- CustEmail - varchar(25)
        'Valid'  -- CustStatus - varchar(10)
    ),
    (
        'C002', -- CustCode - varchar(5)
        'Anil Thakkar', -- CustName - varchar(30)
        'Line Ali Road', -- CustAddress - varchar(50)
        '657654323', -- CustPhone - varchar(15)
        'Thakkar2002@yahoo.com', -- CustEmail - varchar(25)
        'Valid'  -- CustStatus - varchar(10)
    ),
    (
        'C004', -- CustCode - varchar(5)
        'Sanjay Gupta', -- CustName - varchar(30)
        'Link Road', -- CustAddress - varchar(50)
        '367654323', -- CustPhone - varchar(15)
        'SanjayG@indiatimes.com', -- CustEmail - varchar(25)
        'Invalid'  -- CustStatus - varchar(10)
    ),
    (
        'C005', -- CustCode - varchar(5)
        'Sagar Vyas', -- CustName - varchar(30)
        'Link Road', -- CustAddress - varchar(50)
        '376543255', -- CustPhone - varchar(15)
        'Sagarvyas@india.com', -- CustEmail - varchar(25)
        'Valid'  -- CustStatus - varchar(10)
    )
GO 

INSERT dbo.tbMessage
    (
        CustCode,
        MsgDetail,
        MsgDate,
        Status
    )
VALUES
    (
        'C001',        -- CustCode - varchar(5)
        'Voice mail always give ACCESS DENIED message',        -- MsgDetail - varchar(300)
        '20140831', -- MsgDate - date
        'Pending'         -- Status - varchar(10)
    ),
    (
        'C005',        -- CustCode - varchar(5)
        'Voice mail activation always give NO ACCESS message',        -- MsgDetail - varchar(300)
        '20140901', -- MsgDate - date
        'Pending'         -- Status - varchar(10)
    ),
    (
        'C001',        -- CustCode - varchar(5)
        'Please send all future bill to my residential address instead of my office address',        -- MsgDetail - varchar(300)
        '20140905', -- MsgDate - date
        'Resolved'         -- Status - varchar(10)
    ),
    (
        'C004',        -- CustCode - varchar(5)
        'Please send new monthly brochure …',        -- MsgDetail - varchar(300)
        '20141108', -- MsgDate - date
        'Pending'         -- Status - varchar(10)
    )
GO 

/*
	4. a. Create a clustered index IX_Name for CustName column on tbCustomer table.
	   b. Create a composite index IX_CustMsg fot CustCode and MsgNo columns on tbMessage table
*/

CREATE CLUSTERED INDEX IX_Name ON dbo.tbCustomer(CustName)
GO 
CREATE CLUSTERED INDEX IX_CustMsg ON dbo.tbMessage(CustCode,MsgNo)
GO 

/*
	5. Write a query to display the list of customers have no message sent yet.
*/
SELECT *
FROM dbo.tbCustomer a
WHERE NOT EXISTS(SELECT * FROM dbo.tbMessage b WHERE a.CustCode=b.CustCode)
GO 

/*
	6. Create a view vReport which displays messages sended after 1 – Sep – 2014 as following:
		MsgNo MsgDetails			DatePosted	 PostedBy			Status
		1002  Please send all …		09/05/2014	 RahulKhana			Resolved
		1003  Please send new…		11/08/2014	 Sanjay Gupta		Pending
		…
	Note: The definition of view must be hidden from users.
*/
CREATE VIEW vReport 
WITH ENCRYPTION
AS
SELECT b.MsgNo,b.MsgDetail,b.MsgDate AS [DatePosted],a.CustName AS [PostedBy],a.CustStatus AS [Status]
FROM dbo.tbCustomer a JOIN dbo.tbMessage b ON b.CustCode = a.CustCode
GO 

SELECT * FROM dbo.vReport
GO 

/*
	7. Create a store procedure uspChangeStatus to modify CustStatus column in Customer table from “invalid” to “valid” and display the number of records were changed.
*/

CREATE PROC uspChangeStatus
@sodong INT OUTPUT 
AS
BEGIN 
	--Bước 1 Liệt kê danh sách Customer sắp xếp theo Status
	SELECT *
	FROM dbo.tbCustomer 
	ORDER BY CustStatus;
	--Bước 2 Cập nhật Status 
	UPDATE dbo.tbCustomer 
	SET CustStatus='Valid' 
	WHERE CustStatus='Invalid' ;
	--Bước 3 Cập nhật biến Output
	SET @sodong=@@ROWCOUNT
	--Bước 4 Liệt kê bảng sau khi update
	SELECT *
	FROM dbo.tbCustomer 
	ORDER BY CustStatus;
END 
GO 

DECLARE @SoKQ INT;
EXEC dbo.uspChangeStatus
    @sodong = @SoKQ OUTPUT -- int
SELECT @SoKQ AS N'Number of Records Changed'
GO 

/*
	8. Create a store procedure uspCountStatus to count and return the number of messages (output parameter) depending on the given status (input parameter)
*/
CREATE PROC usbCountStatus 
@mes_status VARCHAR(10) , @sotinnhan INT OUTPUT
AS 
BEGIN
	--Bước 1 Hiển thị bảng theo yêu cầu
    SELECT *
	FROM dbo.tbMessage
	WHERE [Status]=@mes_status
	--Bước 2 Cập nhật biến @sotinnhan
	SET @sotinnhan =@@ROWCOUNT
END
GO 

DECLARE @sotinnhan INT;
EXEC dbo.usbCountStatus
    @mes_status = 'Resolved',              -- varchar(10)
    @sotinnhan = @sotinnhan OUTPUT -- int
SELECT @sotinnhan AS N'Tổng số tin nhắn'
GO 

DECLARE @sotinnhan INT;
EXEC dbo.usbCountStatus
    @mes_status = 'Pending',              -- varchar(10)
    @sotinnhan = @sotinnhan OUTPUT -- int
SELECT @sotinnhan AS N'Tổng số tin nhắn'
GO 

/*
	9. Create a trigger tgCustomerInvalid for table tbCustomer which will perform rollback transaction when a new record is inserted which customer has status is invalid and display appropriate messages.
*/
CREATE TRIGGER tgCustomerInvalid
ON dbo.tbCustomer
FOR INSERT AS
BEGIN
	DECLARE @trangthai VARCHAR(10)
	SELECT @trangthai = CustStatus FROM Inserted
	IF @trangthai ='Invalid' 
	BEGIN
		PRINT N'Bạn không được Insert trạng thái Customer là Invalid'
		ROLLBACK
	END 
END
GO 

--Kiểm tra Insert Customer có Status Invalid có báo lỗi không !
INSERT dbo.tbCustomer
    (
        CustCode,
        CustName,
        CustAddress,
        CustPhone,
        CustEmail,
        CustStatus
    )
VALUES
    (
        'C008', -- CustCode - varchar(5)
        'ABC', -- CustName - varchar(30)
        'ABC', -- CustAddress - varchar(50)
        '123545634', -- CustPhone - varchar(15)
        '4343245', -- CustEmail - varchar(25)
        'Invalid'  -- CustStatus - varchar(10)
    )
GO 

/*
	10. Create a trigger tgCustomer for table tbCustomer which deletes all related records in table tbMessage whenever a record of tbCustomer is deleted.
*/

CREATE TRIGGER tgCustomer
ON dbo.tbCustomer
INSTEAD OF DELETE AS 
BEGIN 
	DELETE FROM dbo.tbMessage WHERE CustCode IN (SELECT Deleted.CustCode FROM Deleted) ;
	DELETE FROM dbo.tbCustomer WHERE CustCode IN (SELECT CustCode FROM Deleted)
END 
GO 

--Check Trigger 
--Insert thêm dữ liệu để chút test xóa :) 
INSERT dbo.tbCustomer
    (
        CustCode,
        CustName,
        CustAddress,
        CustPhone,
        CustEmail,
        CustStatus
    )
VALUES
    (
        'C010', -- CustCode - varchar(5)
        'Create to Delete 1', -- CustName - varchar(30)
        'ABC', -- CustAddress - varchar(50)
        '123456', -- CustPhone - varchar(15)
        'ABC@BCD', -- CustEmail - varchar(25)
        'Valid'  -- CustStatus - varchar(10)
    ),
    (
        'C011', -- CustCode - varchar(5)
        'Create to Delete 2', -- CustName - varchar(30)
        'FEG', -- CustAddress - varchar(50)
        '8965235', -- CustPhone - varchar(15)
        'ABC@BCD', -- CustEmail - varchar(25)
        'Valid'  -- CustStatus - varchar(10)
    )
GO 

INSERT dbo.tbMessage
    (
        CustCode,
        MsgDetail,
        MsgDate,
        Status
    )
VALUES
    (
        'C010',        -- CustCode - varchar(5)
        'Spam email ne',        -- MsgDetail - varchar(300)
        GETDATE(), -- MsgDate - date
        'Pending'         -- Status - varchar(10)
    ),
    (
        'C010',        -- CustCode - varchar(5)
        'Tui nhan tin choi cho vui thoi',        -- MsgDetail - varchar(300)
        '20201010', -- MsgDate - date
        'Pending'         -- Status - varchar(10)
    ),
    (
        'C011',        -- CustCode - varchar(5)
        'Xoa tui di , Ngai ngung gi nua',        -- MsgDetail - varchar(300)
        GETDATE(), -- MsgDate - date
        'Resolved'         -- Status - varchar(10)
    ),
    (
        'C011',        -- CustCode - varchar(5)
        'Doi mai ma ko thay thu minh bi xoa, Chan !',        -- MsgDetail - varchar(300)
        '20151212', -- MsgDate - date
        'Resolved'         -- Status - varchar(10)
    )
GO 


--Test Trigger , Xóa 2 Customer có CustCode = C010 và C011
SELECT * FROM dbo.tbCustomer
SELECT * FROM dbo.tbMessage
GO 

DELETE FROM dbo.tbCustomer WHERE CustCode='C010'
GO 
DELETE FROM dbo.tbCustomer WHERE CustCode='C011'
GO 


