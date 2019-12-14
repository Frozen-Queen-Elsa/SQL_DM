--Prestest 2
/*
	1. Create a database named Pretest2DB with the following specifications :
	a. Primary file group with the data file pretest2.mdf. The size, maximum size, and file growth should be 5, 50 and 10% respectively.
	b. File group GroupData with the data file pretest2b.ndf. The size, maximum size, and file growth should be 10, unlimited, and 5 respectively.
	c. Log file pretest2_log.ldf. The size, maximum size, and file growth should be 2, unlimited, and 10% respectively.
*/

CREATE DATABASE Pretest2DB
ON PRIMARY
(NAME='pretest2',FILENAME='D:\Study\Aptech\Season1\SQL\Database\pretest2.mdf',SIZE=5,MAXSIZE=50,FILEGROWTH=10%),
FILEGROUP MyFileGroup
(NAME='pretest2b',FILENAME='D:\Study\Aptech\Season1\SQL\Database\pretest2b.ndf',SIZE=10,MAXSIZE=UNLIMITED,FILEGROWTH=5)
LOG ON 
(name = 'pretest2_log', filename = 'D:\Study\Aptech\Season1\SQL\Database\pretest2_log.ldf', 
size = 2, maxsize = UNLIMITED, filegrowth = 10%)
GO 

USE Pretest2DB
GO 

/*
	2. Create the table tbFlight in the database, applying the specified appropriate constraints:
	- Aircaftcode: primary key
	- FType : only accept ‘Boeing’ or ‘Airbus’
	- Hours: from 1 to 20
*/

CREATE TABLE tbFlight
(
	Aircraftcode NVARCHAR(10) PRIMARY KEY NONCLUSTERED,
	FType NVARCHAR(10) CHECK(FType IN ('Boeing','Airbus')),
	[Source] NVARCHAR(20),
	Destination NVARCHAR(20),
	DepTime TIME ,
	JourneyHrs INT CHECK(JourneyHrs BETWEEN 1 AND 20)
)
GO 

INSERT dbo.tbFlight
    (
        Aircraftcode,
        FType,
        Source,
        Destination,
        DepTime,
        JourneyHrs
    )
VALUES
    (
        N'UA01',       -- Aircraftcode - nvarchar(10)
        N'Boeing',       -- FType - nvarchar(10)
        N'Los Angeles',       -- Source - nvarchar(20)
        N'LonDon',       -- Destination - nvarchar(20)
        '15:30:00', -- DepTime - date
        6          -- JourneyHrs - int
    ),
    (
        N'UA02',       -- Aircraftcode - nvarchar(10)
        N'Boeing',       -- FType - nvarchar(10)
        N'California',       -- Source - nvarchar(20)
        N'New York',       -- Destination - nvarchar(20)
        '09:30:00', -- DepTime - date
        8          -- JourneyHrs - int
    ),
    (
        N'SA01',       -- Aircraftcode - nvarchar(10)
        N'Boeing',       -- FType - nvarchar(10)
        N'Istanbul',       -- Source - nvarchar(20)
        N'Ankara',       -- Destination - nvarchar(20)
        '10:45:00', -- DepTime - date
        8          -- JourneyHrs - int
    ),
    (
        N'SA02',       -- Aircraftcode - nvarchar(10)
        N'Airbus',       -- FType - nvarchar(10)
        N'London',       -- Source - nvarchar(20)
        N'Moscow',       -- Destination - nvarchar(20)
        '11:15:00', -- DepTime - date
        9          -- JourneyHrs - int
    ),
    (
        N'SQ01',       -- Aircraftcode - nvarchar(10)
        N'Airbus',       -- FType - nvarchar(10)
        N'Sydney',       -- Source - nvarchar(20)
        N'Anakara',       -- Destination - nvarchar(20)
        '01:45:00', -- DepTime - date
        15          -- JourneyHrs - int
    ),
    (
        N'SQ02',       -- Aircraftcode - nvarchar(10)
        N'Boeing',       -- FType - nvarchar(10)
        N'Perth',       -- Source - nvarchar(20)
        N'Aden',       -- Destination - nvarchar(20)
        '13:30:00', -- DepTime - date
        10          -- JourneyHrs - int
    ),
    (
        N'SQ03',       -- Aircraftcode - nvarchar(10)
        N'Airbus',       -- FType - nvarchar(10)
        N'San Francisco',       -- Source - nvarchar(20)
        N'Nairobi',       -- Destination - nvarchar(20)
        '15:45:00', -- DepTime - date
        15          -- JourneyHrs - int
    )
GO 

SELECT * FROM dbo.tbFlight
GO 

/*
	4. a. Create a clustered index IX_Source for Source column on tbFlight table.
		b. Create an index IX_Destination for Destination column on tbFlight table
*/

CREATE CLUSTERED INDEX IX_Source ON dbo.tbFlight([Source])
GO 
CREATE INDEX IX_Destination ON dbo.tbFlight(Destination)
GO 

/*
	5. Write a query to display the flights that have journey hours less than 9.
*/
SELECT *
FROM dbo.tbFlight
WHERE JourneyHrs<9
GO 

/*
	6. Create a view vwBoeing which contains flights that have Boeing aircrafts.
	Note: this view will need to check for domain integrity.
*/
CREATE VIEW vwBoeing 
AS 
SELECT *
FROM dbo.tbFlight
WHERE FType='Boeing'
WITH CHECK OPTION
GO 

SELECT * FROM dbo.vwBoeing
GO 

/*
	7. Create a store procedure uspChangeHour to increase journey hours by a given value (input parameter)
*/
CREATE PROC uspChangeHour
@sogio INT =NULL 
AS
BEGIN
	--Nếu không nhập số giờ thì sẽ lấy Default =1
	IF @sogio IS NULL 
		SET @sogio=1  --Giá trị Default =1
		
	--Lệnh 1
	SELECT * FROM dbo.tbFlight
	--Lệnh 2
	UPDATE dbo.tbFlight SET JourneyHrs+=@sogio 
	--Lệnh 3
	SELECT * FROM dbo.tbFlight
END 
GO 

EXEC dbo.uspChangeHour
    @sogio = 2 -- int
GO 

/*
	8. Create a trigger tgFlightInsert for table tbFlight which will perform rollback transaction if a new record has the source same as the destination and display appropriate error message.
*/
CREATE TRIGGER tgFlightInsert
ON dbo.tbFlight
FOR INSERT,UPDATE AS
BEGIN
	DECLARE @xuatphat NVARCHAR(20)
	DECLARE @diemden NVARCHAR(20)
	SELECT @xuatphat=Inserted.Source,@diemden=Inserted.Destination FROM Inserted
	IF @xuatphat=@diemden 
	BEGIN
		PRINT N'Không được nhập Destination giống với Source'		
		ROLLBACK
	END 
END 

--Check trigger
INSERT dbo.tbFlight
    (
        Aircraftcode,
        FType,
        Source,
        Destination,
        DepTime,
        JourneyHrs
    )
VALUES
    (
        N'NhapDai01',        -- Aircraftcode - nvarchar(10)
        N'Boeing',        -- FType - nvarchar(10)
        N'Sài Gòn',        -- Source - nvarchar(20)
        N'Sài Gòn',        -- Destination - nvarchar(20)
        '02:21:59', -- DepTime - time
        10           -- JourneyHrs - int
    )
GO

UPDATE dbo.tbFlight SET Destination='Perth' WHERE Aircraftcode='SQ02'
GO 


/*
	9. Create a trigger tgFlightUpdate for table tbFlight which is not allowed to change value of aircraft code
*/
CREATE TRIGGER tgFlightUpdate
ON dbo.tbFlight
FOR UPDATE AS 
BEGIN
	IF UPDATE(Aircraftcode)
	BEGIN 
		PRINT N'Không được thay đổi giá trị Aircraft Code'
		ROLLBACK
	END 
END 
GO 

--Test Trigger
UPDATE dbo.tbFlight SET Aircraftcode='ND01' WHERE Aircraftcode='UA01'
