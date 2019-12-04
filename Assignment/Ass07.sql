--1 . Create a database called ASM7 which has two data files: one belongs to Primary group, and the other belongs to the secondary file group named ‘MyFileGroup’ with the size, max size, file growth are 10MB, 15MB, and 20%, respectively.
CREATE DATABASE dbASM7
ON PRIMARY
(NAME='dbASM7',FILENAME='D:\Study\Aptech\Season1\SQL\Database\dbASM7.mdf',SIZE=10,MAXSIZE=15,FILEGROWTH=20%),
FILEGROUP MyFileGroup
(NAME='dbASM7_2',FILENAME='D:\Study\Aptech\Season1\SQL\Database\dbASM7_2.ndf',SIZE=10,MAXSIZE=15,FILEGROWTH=20%)
GO 

USE dbASM7
GO 


--2 .Create the the following tables: 
-- a. “tbBatch” table
-- b. “tbStudent” table
--	- Write a query (check constraint) to accept only positive number and less than (<) 6 in the Size field of table	tbBatch
--	- Write a query (check constraint) to accept only 2 values ‘M’ and ‘F’ in the Gender field of table tbStudent
--	- Write a query (check constraint) to accept only value of field EnrollYear >=2000
--	- Add at least 4 records in table “tbBatch” and 8 records in table “tbStudent”

CREATE TABLE tbBatch
(
	BatchNo VARCHAR(10) PRIMARY KEY ,
	Size INT CHECK(Size > 0 AND Size <6), --Number of students
	TimeSlot VARCHAR(20) ,
	RoomNo VARCHAR(10)
)
GO 

CREATE TABLE tbStudent
(
	RollNo VARCHAR(10) PRIMARY KEY,	
	LastName VARCHAR(20) NOT NULL,
	FirstName VARCHAR(20) NOT NULL,
	Gender VARCHAR(1) NOT NULL DEFAULT 'M' CHECK(Gender ='F' OR Gender ='M'),
	DoB DATE,
	[Address] VARCHAR(40),
	EnrollYear SMALLINT NOT NULL DEFAULT YEAR(GETDATE()) CHECK(EnrollYear>=2000),
	BatchNo VARCHAR(10) FOREIGN KEY REFERENCES dbo.tbBatch(BatchNo)
)
GO 

INSERT dbo.tbBatch
    (
        BatchNo,
        Size,
        TimeSlot,
        RoomNo
    )
VALUES
    (
        'KPop', -- BatchNo - varchar(10)
        3,  -- Size - int
        'MWF_Morning', -- TimeSlot - varchar(20)
        'R246_M'  -- RoomNo - varchar(10)
    ),
    (
        'Rock&Roll', -- BatchNo - varchar(10)
        4,  -- Size - int
        'TTS_Afternoon', -- TimeSlot - varchar(20)
        'R357_A'  -- RoomNo - varchar(10)
    ),
    (
        'Rap', -- BatchNo - varchar(10)
        2,  -- Size - int
        'SS_Evening', -- TimeSlot - varchar(20)
        'R078_E'  -- RoomNo - varchar(10)
    ),
    (
        'Country', -- BatchNo - varchar(10)
        5,  -- Size - int
        'All_Night', -- TimeSlot - varchar(20)
        'R027_N'  -- RoomNo - varchar(10)
    ),
    (
        'Pop', -- BatchNo - varchar(10)
        3,  -- Size - int
        'All_Morning', -- TimeSlot - varchar(20)
        'R072_M'  -- RoomNo - varchar(10)
    ),
    (
        'Opera', -- BatchNo - varchar(10)
        5,  -- Size - int
        'All_Afternoon', -- TimeSlot - varchar(20)
        'R207_A'  -- RoomNo - varchar(10)
    )
GO 

INSERT dbo.tbStudent
    (
        RollNo,
        LastName,
        FirstName,
        Gender,
        DoB,
        [Address],
        EnrollYear,
        BatchNo
    )
VALUES
    (
        'ST01',        -- RollNo - varchar(10)
        'Arvil',        -- LastName - varchar(20)
        'Lavigne',        -- FirstName - varchar(20)
        'F',        -- Gender - varchar(1)
        '19920309', -- DoB - date
        'Canada',        -- Address - varchar(40)
        '2019',         -- EnrollYear - smallint
        'Rock&Roll'         -- BatchNo - varchar(10)
    ),
    (
        'ST02',        -- RollNo - varchar(10)
        'Taylor',        -- LastName - varchar(20)
        'Swift',        -- FirstName - varchar(20)
        'F',        -- Gender - varchar(1)
        '20050808', -- DoB - date
        'USA',        -- Address - varchar(40)
        '2018',         -- EnrollYear - smallint
        'Country'         -- BatchNo - varchar(10)
    ),
    (
        'ST03',        -- RollNo - varchar(10)
        'Kim',        -- LastName - varchar(20)
        'Taeyeon',        -- FirstName - varchar(20)
        'F',        -- Gender - varchar(1)
        '20060101', -- DoB - date
        'Korea',        -- Address - varchar(40)
        '2010',         -- EnrollYear - smallint
        'KPop'         -- BatchNo - varchar(10)
    ),
    (
        'ST04',        -- RollNo - varchar(10)
        'Seo',        -- LastName - varchar(20)
        'Joo-hyun',        -- FirstName - varchar(20)
        'F',        -- Gender - varchar(1)
        '19910909', -- DoB - date
        'Korea',        -- Address - varchar(40)
        '2010',         -- EnrollYear - smallint
        'KPop'         -- BatchNo - varchar(10)
    ),
    (
        'ST05',        -- RollNo - varchar(10)
        'Miley',        -- LastName - varchar(20)
        'Cirus',        -- FirstName - varchar(20)
        'F',        -- Gender - varchar(1)
        '19960808', -- DoB - date
        'USA',        -- Address - varchar(40)
        '2017',         -- EnrollYear - smallint
        'Rap'         -- BatchNo - varchar(10)
    ),
    (
        'ST06',        -- RollNo - varchar(10)
        'Michael',        -- LastName - varchar(20)
        'Jackson',        -- FirstName - varchar(20)
        'M',        -- Gender - varchar(1)
        '19580829', -- DoB - date
        'USA',        -- Address - varchar(40)
        '2001',         -- EnrollYear - smallint
        'Pop'         -- BatchNo - varchar(10)
    ),
    (
        'ST07',        -- RollNo - varchar(10)
        'Christina',        -- LastName - varchar(20)
        'Anguilera',        -- FirstName - varchar(20)
        'F',        -- Gender - varchar(1)
        '20020506', -- DoB - date
        'Korea',        -- Address - varchar(40)
        '2005',         -- EnrollYear - smallint
        'Pop'         -- BatchNo - varchar(10)
    ),
    (
        'ST08',        -- RollNo - varchar(10)
        'Dmitry',        -- LastName - varchar(20)
        'Khvorostovsky',        -- FirstName - varchar(20)
        'M',        -- Gender - varchar(1)
        '19850808', -- DoB - date
        'Rusia',        -- Address - varchar(40)
        '2015',         -- EnrollYear - smallint
        'Opera'         -- BatchNo - varchar(10)
    ),
    (
        'ST09',        -- RollNo - varchar(10)
        'Feng',        -- LastName - varchar(20)
        'Timo',        -- FirstName - varchar(20)
        'F',        -- Gender - varchar(1)
        '20001212', -- DoB - date
        'China',        -- Address - varchar(40)
        '2019',         -- EnrollYear - smallint
        'Pop'         -- BatchNo - varchar(10)
    )
GO 

--3. Write Queries to retrieve the following information :
--	a. list of students sorted by gender and date of birth
--	b. count number of students grouped by gender .
--	c. list of students who have more 18 year-old, consisting of the columns: rollno, full name (lastname + firstname), gender, dob, address, batchno, roomno

-- 3a list of students sorted by gender and date of birth
SELECT *
FROM dbo.tbStudent
ORDER BY Gender, DoB   -- Hỏi lại cô thế này là sắp xếp theo 2 cái chưa ?
GO 

-- 3b. count number of students grouped by gender .
SELECT Gender,COUNT(*) AS N'Tổng số học sinh' 
FROM dbo.tbStudent
GROUP BY Gender
GO 

-- 3c. list of students who have more 18 year-old, consisting of the columns: rollno, full name (lastname + firstname), gender, dob, address, batchno, roomno

--Cách 1 Xài SubQuerry
SELECT a.RollNo,(a.LastName + a.FirstName) AS [FullName],a.Gender,a.DoB,DATEDIFF(yy,DoB,GETDATE()) AS N'Tuổi',a.[Address],b.BatchNo,b.RoomNo
FROM dbo.tbStudent a, dbo.tbBatch b 
WHERE a.RollNo IN (SELECT a.RollNo FROM dbo.tbStudent WHERE DATEDIFF(yy,a.DoB,GETDATE())>18) 
	  AND 
	  b.BatchNo IN (SELECT BatchNo FROM dbo.tbBatch WHERE BatchNo=a.BatchNo)
GO 

--Cách 2 Xài Join
SELECT  a.RollNo,(a.LastName + a.FirstName) AS [FullName],a.Gender,a.DoB,DATEDIFF(yy,DoB,GETDATE()) AS N'Tuổi',a.[Address],b.BatchNo,b.RoomNo 
FROM dbo.tbStudent a JOIN dbo.tbBatch b ON b.BatchNo = a.BatchNo
WHERE DATEDIFF(yy,a.DoB,GETDATE())>18
GO 
 