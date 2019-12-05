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
	CustCode VARCHAR(5) PRIMARY KEY ,   
	CustName VARCHAR(30) NOT NULL ,		
	CustAddress VARCHAR(50) NOT NULL ,	
	CustPhone VARCHAR(15) ,				
	CustEmail VARCHAR(25) , 
	CustStatus VARCHAR(10) DEFAULT 'Valid' CHECK(CustStatus='Valid' OR CustStatus='Invalid')
)
GO 

CREATE TABLE tbMessage
(
	MsgNo INT IDENTITY(1000,1) PRIMARY KEY,
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