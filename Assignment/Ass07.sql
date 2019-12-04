--1 . Create a database called ASM7 which has two data files: one belongs to Primary group, and the other belongs to the secondary file group named ‘MyFileGroup’ with the size, max size, file growth are 10MB, 15MB, and 20%, respectively.
CREATE DATABASE ASM7
ON PRIMARY
(NAME='dbASM7',FILENAME='D:\Study\Aptech\Season1\SQL\Database\dbASM7.mdf',SIZE=10,MAXSIZE=15,FILEGROWTH=20%),
FILEGROUP MyFileGroup
(NAME='dbASM7_2',FILENAME='D:\Study\Aptech\Season1\SQL\Database\dbASM7_2.ndf',SIZE=10,MAXSIZE=15,FILEGROWTH=20%)
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
	EnrollYear SMALLINT NOT NULL DEFAULT YEAR(GETDATE()) CHECK(YEAR(EnrollYear)>=2000),
	BatchNo VARCHAR(10) FOREIGN KEY REFERENCES dbo.tbBatch(BatchNo)
)