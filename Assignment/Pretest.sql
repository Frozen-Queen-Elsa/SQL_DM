--Pretest

/*
	1. Create a database named dbPretest
*/
CREATE DATABASE dbPretest
GO 

USE dbPretest
GO 

/*
	2. Create the following tables in Database dbPretest
*/
CREATE TABLE tbRoom
(
	RoomNo INT PRIMARY KEY NONCLUSTERED,
	[Type] VARCHAR(20) CHECK([Type] IN ('VIP','Double','Single')),
	UnitPrice MONEY CHECK(UnitPrice BETWEEN 0 AND 999) 
)
GO 

CREATE TABLE tbBooking
(
	BookingNo INT ,
	RoomNo INT FOREIGN KEY REFERENCES dbo.tbRoom(RoomNo),
	TouristName VARCHAR(20) NOT NULL,
	DateFrom DATETIME,
	DateTo DATETIME ,
	PRIMARY KEY NONCLUSTERED(BookingNo,RoomNo) 
)
GO 

ALTER TABLE dbo.tbBooking
	ADD CONSTRAINT DateTo CHECK(DateTo>DateFrom)
GO 

INSERT dbo.tbRoom
    (
        RoomNo,
        [Type],
        UnitPrice
    )
VALUES
    (
        101,   -- RoomNo - int
        'Single',  -- Type - varchar(20)
        100 -- UnitPrice - money
    ),
    (
        102,   -- RoomNo - int
        'Single',  -- Type - varchar(20)
        100 -- UnitPrice - money
    ),
    (
        103,   -- RoomNo - int
        'Double',  -- Type - varchar(20)
        250 -- UnitPrice - money
    ),
    (
        201,   -- RoomNo - int
        'Double',  -- Type - varchar(20)
        250 -- UnitPrice - money
    ),
    (
        202,   -- RoomNo - int
        'Double',  -- Type - varchar(20)
        300 -- UnitPrice - money
    ),
    (
        203,   -- RoomNo - int
        'Single',  -- Type - varchar(20)
        150 -- UnitPrice - money
    ),
    (
        301,   -- RoomNo - int
        'VIP',  -- Type - varchar(20)
        900 -- UnitPrice - money
    )
GO 

INSERT dbo.tbBooking
    (
        BookingNo,
        RoomNo,
        TouristName,
        DateFrom,
        DateTo
    )
VALUES
    (
        1,         -- BookingNo - int
        101,         -- RoomNo - int
        'Julia',        -- TouristName - varchar(20)
        '20141112', -- DateFrom - datetime
        '20141114'  -- DateTo - datetime
    ),
    (
        1,         -- BookingNo - int
        103,         -- RoomNo - int
        'Julia',        -- TouristName - varchar(20)
        '20141212', -- DateFrom - datetime
        '20141213'  -- DateTo - datetime
    ),
    (
        2,         -- BookingNo - int
        301,         -- RoomNo - int
        'Bill',        -- TouristName - varchar(20)
        '20150110', -- DateFrom - datetime
        '20150114'  -- DateTo - datetime
    ),
    (
        3,         -- BookingNo - int
        201,         -- RoomNo - int
        'Ana',        -- TouristName - varchar(20)
        '20150112', -- DateFrom - datetime
        '20150114'  -- DateTo - datetime
    ),
    (
        3,         -- BookingNo - int
        202,         -- RoomNo - int
        'Ana',        -- TouristName - varchar(20)
        '20150112', -- DateFrom - datetime
        '20150114'  -- DateTo - datetime
    ),
	(
        3,         -- BookingNo - int
        301,         -- RoomNo - int
        'Seohyun',        -- TouristName - varchar(20)
        '20181210', -- DateFrom - datetime
        '20181212'  -- DateTo - datetime
    )
GO 

/*
	3. Create a clustered index ixName on column TouristName of table tbBooking
	4. Create a non-clustered index ixType on column Type of table tbRoom
*/

CREATE CLUSTERED INDEX ixName ON dbo.tbBooking(TouristName)
GO
CREATE NONCLUSTERED INDEX ixType ON dbo.tbRoom([Type])
GO 

/*
	5. Create a view vwBooking to see the information about bookings in year 2014 which contain the following columns:
	BookingNo, TouristName, RoomNo,Type, UnitPrice, DateFrom, DateTo. The definition of view must be encrypted.
*/

CREATE VIEW vwBooking
WITH ENCRYPTION
AS 
SELECT a.BookingNo,a.TouristName,b.RoomNo,[b].[Type],b.UnitPrice,a.DateFrom,a.DateTo
FROM dbo.tbBooking a JOIN dbo.tbRoom b ON b.RoomNo = a.RoomNo
WHERE YEAR(a.DateFrom)=2014
GO 

SELECT * FROM dbo.vwBooking
GO 

/*
	6. Create a stored procedure name uspPriceDecrease will down the unit price of double rooms a given amount (input parameter). If non value given, display a list of rooms, sorted by price .
*/

CREATE PROC uspPriceDecrease
@gia MONEY 
AS 
BEGIN	
	--Lệnh 1 
	SELECT * 
	FROM dbo.tbRoom
	WHERE [Type]='Double'
	ORDER BY UnitPrice ;
	--Lệnh 2
	UPDATE dbo.tbRoom SET UnitPrice-=@gia WHERE [Type]='Double'
	--Lệnh 3
	IF @@ROWCOUNT=0
	BEGIN
		SELECT *
		FROM dbo.tbRoom
		ORDER BY UnitPrice DESC		
	END
	ELSE 
	BEGIN 
		SELECT *
		FROM dbo.tbRoom
		WHERE [Type]='Double'
		ORDER BY UnitPrice DESC 
	END 
END  
GO 

SELECT * FROM dbo.tbRoom
GO 

EXEC dbo.uspPriceDecrease
    @gia = 10 -- money
GO 
/*
	7. Create a stored procedure name uspSpecificPriceIncrease will increment the unit price of a given room (input parameter) by a given amount (input parameter) and return the number of rooms (output parameter) which have room rate above 250.
*/

CREATE PROC uspSpecificPriceIncrease
@maphong INT,@gia MONEY,@sophong INT OUTPUT 
AS
BEGIN
	--Lệnh 1
	SELECT *
	FROM dbo.tbRoom
	WHERE RoomNo=@maphong	;
	--Lệnh 2
	UPDATE dbo.tbRoom SET UnitPrice += @gia WHERE RoomNo=@maphong
	--Lệnh 3
	SET @sophong = (SELECT COUNT(*) FROM dbo.tbRoom WHERE UnitPrice>=250) ;
	--Lệnh 4 
	SELECT *
	FROM dbo.tbRoom
	ORDER BY UnitPrice ;
END 
GO 

SELECT * FROM dbo.tbRoom
GO 

DECLARE @sophong INT;
EXEC dbo.uspSpecificPriceIncrease
    @maphong = 103,              -- int
    @gia = 20,               -- money
    @sophong = @sophong OUTPUT -- int
SELECT @sophong AS N'Tổng số phòng có giá >250' 
GO 

/*
	8. Create a trigger named tgBookingRoom that allows one booking order having 3 rooms maximum.
*/
alter TRIGGER tgBookingRoom
ON dbo.tbBooking
AFTER INSERT,UPDATE AS
BEGIN
	DECLARE @sophong INT
	DECLARE @maso INT
	SELECT @maso=Inserted.BookingNo FROM Inserted
	SELECT @sophong=COUNT(*) FROM dbo.tbBooking WHERE BookingNo=@maso GROUP BY BookingNo
	IF @sophong>3
	BEGIN
		PRINT N'Mỗi Booking Order chi duoc dang ky toi da 3 phong'
		ROLLBACK
    END 
END
GO 



sp_helptext tgBookingRoom

SELECT * FROM dbo.tbBooking
SELECT COUNT(BookingNo) FROM dbo.tbBooking 
SELECT COUNT(RoomNo)+1 FROM dbo.tbBooking GROUP BY BookingNo
--Test trigger
INSERT dbo.tbBooking
    (
        BookingNo,
        RoomNo,
        TouristName,
        DateFrom,
        DateTo
    )
VALUES
    (
        3,         -- BookingNo - int
        103,         -- RoomNo - int
        'Taeyeon',        -- TouristName - varchar(20)
        '20181210', -- DateFrom - datetime
        '20181212'  -- DateTo - datetime
    ),
	(
        3,         -- BookingNo - int
        101,         -- RoomNo - int
        'Taeyeon',        -- TouristName - varchar(20)
        '20181210', -- DateFrom - datetime
        '20181212'  -- DateTo - datetime
    )

GO 


SELECT * FROM dbo.tbBooking
GO 


/*
	9. Create a trigger named tgRoomUpdate that doing the following (using try-catch structure) : 
		If new price is equal to 0 and this room has not existed in tbBooking, then remove it from tbRoom table
		Else display an error message and roll back transaction.
*/
--???


alter TRIGGER tgRoomUpdate
ON dbo.tbRoom 
INSTEAD OF UPDATE AS
BEGIN
	DECLARE @sophong INT
	DECLARE @dongia money 
	SELECT @sophong=Inserted.RoomNo,@dongia=Inserted.UnitPrice FROM Inserted
	BEGIN TRY 
		IF @dongia=0 
		BEGIN 
			DELETE FROM dbo.tbRoom WHERE RoomNo=@sophong
		END 
		ELSE 
		BEGIN
			UPDATE dbo.tbRoom SET UnitPrice=@dongia WHERE RoomNo=@sophong
		END 
	END TRY 
	BEGIN CATCH
		SELECT ERROR_LINE()  N'Dòng lỗi',ERROR_MESSAGE() N'Thanh báo lỗi' , ERROR_NUMBER() N'Mã số lỗi sai'
		
		ROLLBACK
	END CATCH
END
GO 



SELECT * FROM dbo.tbRoom
SELECT * FROM dbo.tbBooking
GO 
--Test Trigger
--Tạo thêm 1 room không có trong booking để cập nhật giá =0
INSERT dbo.tbRoom
    (
        RoomNo,
        Type,
        UnitPrice
    )
VALUES
    (
        404,   -- RoomNo - int
        'VIP',  -- Type - varchar(20)
        500 -- UnitPrice - money
    )
GO 


--Check xem có Delete room 404 khi Price =0 không ?
UPDATE dbo.tbRoom SET UnitPrice=0 WHERE RoomNo=404
GO 

SELECT * FROM dbo.tbRoom

----Check xem có báo lỗi khi Update room 301 Price =0 không ?
UPDATE dbo.tbRoom SET UnitPrice=0 WHERE RoomNo=301
GO 

--Check khi update giá bình thường
UPDATE dbo.tbRoom SET UnitPrice=999 WHERE RoomNo=301
GO 

