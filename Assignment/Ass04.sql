CREATE DATABASE StudentDB
ON	
( NAME='Student_dat',FILENAME='D:\Study\Aptech\Season1\SQL\Database\Student_dat.mdf',
  SIZE=5,FILEGROWTH=10%,MAXSIZE=UNLIMITED
)
LOG ON	
( NAME='Student_log',FILENAME='D:\Study\Aptech\Season1\SQL\Database\Student_log.ldf',
  SIZE=2,FILEGROWTH=1,MAXSIZE=15
)
GO	

USE StudentDB
GO	

CREATE TABLE tbStudent
(
	Roll_no INT IDENTITY PRIMARY KEY,
	Fullname VARCHAR(40) NOT NULL,
	Grade VARCHAR(1) NOT NULL,
	Sex VARCHAR(6) DEFAULT 'Female',
	[Address] VARCHAR(60),
	DOB DATE 
)
GO


	   
INSERT dbo.tbStudent
    (
        Fullname,
        Grade,
        Sex,
        [Address],
        DOB
    )
VALUES
    (
        'Rita',       -- Fullname - varchar(40)
        'B',       -- Grade - varchar(1)
        'Female',       -- Sex - varchar(6)
        'New York',       -- Address - varchar(60)
        '19850412' -- DOB - date
    ),
    (
        'Beck',       -- Fullname - varchar(40)
        'A',       -- Grade - varchar(1)
        'Male',       -- Sex - varchar(6)
        'California',       -- Address - varchar(60)
        '19861223' -- DOB - date
    ),
    (
        'Wilson',       -- Fullname - varchar(40)
        'B',       -- Grade - varchar(1)
        'Male',       -- Sex - varchar(6)
        'New Jersey',       -- Address - varchar(60)
        '19880709' -- DOB - date
    ), 
    (
        'Leonard',       -- Fullname - varchar(40)
        'C',       -- Grade - varchar(1)
        'Male',       -- Sex - varchar(6)
        'Ohio',       -- Address - varchar(60)
        '19871217' -- DOB - date
    ),	
    (
        'Julia',       -- Fullname - varchar(40)
        'A',       -- Grade - varchar(1)
        'Female',       -- Sex - varchar(6)
        'Chicago',       -- Address - varchar(60)
        '19860131' -- DOB - date
    ),	
    (
        'Ringo',       -- Fullname - varchar(40)
        'A',       -- Grade - varchar(1)
        'Male',       -- Sex - varchar(6)
        'Atlanta',       -- Address - varchar(60)
        '19851218' -- DOB - date
    ), 
    (
        'Annie',       -- Fullname - varchar(40)
        'C',       -- Grade - varchar(1)
        'Female',       -- Sex - varchar(6)
        'Washington',       -- Address - varchar(60)
        '19880415' -- DOB - date
    ),	   
    (
        'Sandra',       -- Fullname - varchar(40)
        'C',       -- Grade - varchar(1)
        'Female',       -- Sex - varchar(6)
        'California',       -- Address - varchar(60)
        '19860912' -- DOB - date
    ),
    (
        'Tom',       -- Fullname - varchar(40)
        'A',       -- Grade - varchar(1)
        'Male',       -- Sex - varchar(6)
        'Ohio',       -- Address - varchar(60)
        '19870801' -- DOB - date
    ),	 
    (
        'Susie',       -- Fullname - varchar(40)
        'B',       -- Grade - varchar(1)
        'Female',       -- Sex - varchar(6)
        'California',       -- Address - varchar(60)
        '19881203' -- DOB - date
    ),	
    (
        'Bob',       -- Fullname - varchar(40)
        'B',       -- Grade - varchar(1)
        'Male',       -- Sex - varchar(6)
        'Washington',       -- Address - varchar(60)
        '19871204' -- DOB - date
    ),	
    (
        'Rosy',       -- Fullname - varchar(40)
        'C',       -- Grade - varchar(1)
        'Female',       -- Sex - varchar(6)
        'New York',       -- Address - varchar(60)
        '19850305' -- DOB - date
    )


CREATE TABLE tbBatch
(
	Batch_no VARCHAR(10) NOT NULL PRIMARY KEY,
	Course_name VARCHAR(40) NOT NULL,
	[Start_Date] DATE 
)
GO	

INSERT dbo.tbBatch
    (
        Batch_no,
        Course_name,
        Start_Date
    )
VALUES
    (
        'F2_1401',       -- Batch_no - varchar(10)
        'ACCP 2011',       -- Course_name - varchar(40)
        '20140102' -- Start_Date - date
    ),	 
    (
        'F2_1402',       -- Batch_no - varchar(10)
        'ACCP 2011',       -- Course_name - varchar(40)
        '20140201' -- Start_Date - date
    ),	
    (
        'F2_1403',       -- Batch_no - varchar(10)
        'ACCP 2013 new',       -- Course_name - varchar(40)
        '20140305' -- Start_Date - date
    ),	
    (
        'F3_1402',       -- Batch_no - varchar(10)
        'ACCP 2011',       -- Course_name - varchar(40)
        '20140202' -- Start_Date - date
    ),	  
    (
        'F3_1404',       -- Batch_no - varchar(10)
        'ACCP 2013 new',       -- Course_name - varchar(40)
        '20140403' -- Start_Date - date
    )
GO	

CREATE TABLE tbRegister
(
	Batch_no VARCHAR(10) NOT NULL,
	Roll_no INT,
	Comment VARCHAR(100),
	Register_date DATE DEFAULT GETDATE(),
	FOREIGN KEY (Batch_no) REFERENCES dbo.tbBatch,
	FOREIGN KEY (Roll_no) REFERENCES dbo.tbStudent,
	PRIMARY KEY (Batch_no,Roll_no)
)
GO 

SELECT* FROM dbo.tbStudent
GO

SELECT * FROM dbo.tbBatch
GO 

INSERT dbo.tbRegister
    (
        Batch_no,
        Roll_no,
        Comment,
        Register_date
    )
VALUES
    (
        'F2_1401',       -- Batch_no - varchar(10)
        1,        -- Roll_no - int
        'Frozen 2',       -- Comment - varchar(100)
        GETDATE() -- Register_date - date
    ),	
    (
        'F2_1401',       -- Batch_no - varchar(10)
        3,        -- Roll_no - int
        'Frozen 1',       -- Comment - varchar(100)
        GETDATE() -- Register_date - date
    ),	
    (
        'F2_1402',       -- Batch_no - varchar(10)
        2,        -- Roll_no - int
        'Maleficent',       -- Comment - varchar(100)
        GETDATE() -- Register_date - date
    ), 
    (
        'F3_1402',       -- Batch_no - varchar(10)
        12,        -- Roll_no - int
        'Tom and Jerry',       -- Comment - varchar(100)
        GETDATE() -- Register_date - date
    ), 
    (
        'F3_1404',       -- Batch_no - varchar(10)
        10,        -- Roll_no - int
        'Titanic',       -- Comment - varchar(100)
        GETDATE() -- Register_date - date
    ), 
    (
        'F2_1401',       -- Batch_no - varchar(10)
        5,        -- Roll_no - int
        'Pokemon',       -- Comment - varchar(100)
        GETDATE() -- Register_date - date
    )
GO 
