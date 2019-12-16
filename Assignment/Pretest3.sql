/*
	1. Create a database named Pretest3DB with the following specifications :
	a. Primary file group with the data file pretest3.mdf. The size, maximum size, and file growth should be 5, unlimited and 20 respectively.
	b. Log file pretest3_log.ldf. The size, maximum size, and file growth should be 2, 50, and 10% respectively.
*/

CREATE DATABASE Pretest3DB
ON PRIMARY
(NAME='pretest3',FILENAME='D:\Study\Aptech\Season1\SQL\Database\pretest3.mdf',SIZE=5,MAXSIZE=UNLIMITED,FILEGROWTH=20)
LOG ON 
(name = 'pretest3_log', filename = 'D:\Study\Aptech\Season1\SQL\Database\pretest3_log.ldf', 
size = 2, maxsize = 50, filegrowth = 10%)
GO 

USE Pretest3DB
GO 

/*
	2. Create the table tbEmpDetails, tbLeaveDetails as follows:
	- table tbEmpDetails Field
	- table tbLeaveDetails	
*/

CREATE TABLE tbEmpDetail
(
	Emp_Id VARCHAR(5) PRIMARY KEY NONCLUSTERED,
	FullName VARCHAR(30) NOT NULL,
	PhoneNumber VARCHAR(20) NOT NULL,
	Designation VARCHAR(30) CHECK(Designation IN ('Manager','Staff')),
	Salary MONEY CHECK(Salary BETWEEN 0 AND 3000),
	Join_Date DATE
)
GO 

CREATE TABLE tbLeaveDetails
(
	Leave_ID INT IDENTITY PRIMARY KEY NONCLUSTERED,
	Emp_Id VARCHAR(5) FOREIGN KEY REFERENCES dbo.tbEmpDetail,
	LeaveTaken INT CHECK(LeaveTaken BETWEEN 1 AND 14),
	FromDate DATE,
	ToDate DATE ,
	Reason VARCHAR(50) NOT NULL	
)
GO 

ALTER TABLE dbo.tbLeaveDetails
	ADD CONSTRAINT ToDate CHECK(DATEDIFF(dd,FromDate,ToDate)=LeaveTaken)
GO 

/*
	3. Insert at least five records to each table
*/

INSERT dbo.tbEmpDetail
    (
        Emp_Id,
        FullName,
        PhoneNumber,
        Designation,
        Salary,
        Join_Date
    )
VALUES
    (
        'Em01',       -- Emp_Id - varchar(5)
        'Seohyun',       -- FullName - varchar(30)
        '0123456789',       -- PhoneNumber - varchar(20)
        'Manager',       -- Designation - varchar(30)
        3000,     -- Salary - money
        '20170505' -- Join_Date - datetime
    ),
    (
        'Em02',       -- Emp_Id - varchar(5)
        'Taeyeon',       -- FullName - varchar(30)
        '0987654321',       -- PhoneNumber - varchar(20)
        'Staff',       -- Designation - varchar(30)
        2500,     -- Salary - money
        '20180606' -- Join_Date - datetime
    ),
    (
        'Em03',       -- Emp_Id - varchar(5)
        'Yoona',       -- FullName - varchar(30)
        '011223344',       -- PhoneNumber - varchar(20)
        'Manager',       -- Designation - varchar(30)
        2200,     -- Salary - money
        '20190602' -- Join_Date - datetime
    ),
    (
        'Em04',       -- Emp_Id - varchar(5)
        'Sunny',       -- FullName - varchar(30)
        '098999999',       -- PhoneNumber - varchar(20)
        'Staff',       -- Designation - varchar(30)
        1500,     -- Salary - money
        '20190101' -- Join_Date - datetime
    ),
    (
        'Em05',       -- Emp_Id - varchar(5)
        'Tiffany',       -- FullName - varchar(30)
        '0123321123',       -- PhoneNumber - varchar(20)
        'Staff',       -- Designation - varchar(30)
        1000,     -- Salary - money
        '20181231' -- Join_Date - datetime
    )
GO 

INSERT dbo.tbLeaveDetails
    (
        Emp_Id,
        LeaveTaken,
        FromDate,
        ToDate,
        Reason
    )
VALUES
    (
        'Em01',        -- Emp_Id - varchar(5)
        13,         -- LeaveTaken - int
        '20191201', -- FromDate - datetime
        '20191214', -- ToDate - datetime
        'Travel'         -- Reason - varchar(50)
    ),
    (
        'Em02',        -- Emp_Id - varchar(5)
        9,         -- LeaveTaken - int
        '20190105', -- FromDate - datetime
        '20190114', -- ToDate - datetime
        'Live Show'         -- Reason - varchar(50)
    ),
    (
        'Em03',        -- Emp_Id - varchar(5)
        4,         -- LeaveTaken - int
        '20200101', -- FromDate - datetime
        '20200105', -- ToDate - datetime
        'Date'         -- Reason - varchar(50)
    ),
    (
        'Em04',        -- Emp_Id - varchar(5)
        12,         -- LeaveTaken - int
        '20190505', -- FromDate - datetime
        '20190517', -- ToDate - datetime
        'Sick Homeness'         -- Reason - varchar(50)
    ),
    (
        'Em05',        -- Emp_Id - varchar(5)
        11,         -- LeaveTaken - int
        '20191219', -- FromDate - datetime
        '20191230', -- ToDate - datetime
        'Winter Vacation'         -- Reason - varchar(50)
    ),	
    (
        'Em05',        -- Emp_Id - varchar(5)
        3,         -- LeaveTaken - int
        '20200220', -- FromDate - datetime
        '20200223', -- ToDate - datetime
        'Sick'         -- Reason - varchar(50)
    )
GO 

/*
	4. Create a clustered index IX_Fullname for fullname column on tbEmployeeDetails table. Create an index IX_EmpID for Emp_ID column on tbLeaveDetails table
*/
CREATE CLUSTERED INDEX IX_Fullname ON dbo.tbEmpDetail(FullName)
CREATE INDEX IX_EmpID ON dbo.tbLeaveDetails(Emp_Id)
GO 

/*
	5. Create a view vwManager to retrieve the number of leaves taken by employees having designation as Manager Note: this view will need to check for domain integrity and encryption.
*/
CREATE VIEW vwManager
WITH ENCRYPTION
AS 
SELECT a.Emp_Id,a.FullName,a.Designation,SUM(b.LeaveTaken) AS N'Tổng số ngày nghỉ'
FROM dbo.tbEmpDetail a JOIN dbo.tbLeaveDetails b ON b.Emp_Id = a.Emp_Id 
WHERE a.Designation LIKE 'Manager' 
GROUP BY a.Emp_Id,a.FullName,a.Designation
WITH CHECK OPTION 
GO 

SELECT * FROM dbo.vwManager
GO 

/*
6. Create a store procedure uspChangeSalary to increase salary of an employee by a given value (Hint: using input parameters)
*/

CREATE PROC uspChangeSalary
@luong MONEY,@ten VARCHAR(30)
AS
BEGIN 
	--Lệnh 1
	SELECT * FROM dbo.tbEmpDetail WHERE FullName LIKE @ten
	--Lệnh 2
	UPDATE dbo.tbEmpDetail SET Salary+=@luong WHERE FullName LIKE @ten
	--Lệnh 3
	SELECT * FROM dbo.tbEmpDetail WHERE FullName LIKE @ten 
END 
GO 

EXEC dbo.uspChangeSalary
    @luong = 100, -- money
    @ten = 'Tiffany'      -- varchar(30)
GO 

/*
	7. Create a trigger tgInsertLeave for table tbLeaveDetails which will perform rollback
	transaction if total of leaves taken by employees in a year greater than 15 and display
	appropriate error message.
*/
CREATE TRIGGER tgInsertLeave 
ON dbo.tbLeaveDetails
AFTER INSERT ,UPDATE AS 
BEGIN 
	DECLARE @manv VARCHAR(5)	
	DECLARE @songay INT 
	DECLARE @mangaynghi INT 
	SELECT @manv=Inserted.Emp_Id FROM Inserted 
	SELECT @songay=SUM(LeaveTaken) FROM dbo.tbLeaveDetails WHERE emp_id=@manv GROUP BY Emp_Id	
	IF @songay>=15
	BEGIN
		PRINT N'Tổng số ngày nghỉ phép trong 1 năm không được quá 15 ngày'
		ROLLBACK
    END 
END 

--Test trigger
SELECT Emp_Id,SUM(LeaveTaken) AS N'Tong so ngay nghi' FROM dbo.tbLeaveDetails GROUP BY Emp_Id
GO 
--Check update
UPDATE dbo.tbLeaveDetails SET LeaveTaken=10 WHERE Leave_ID ='12'
GO 

--Check Insert
INSERT dbo.tbLeaveDetails
    (
        Emp_Id,
        LeaveTaken,
        FromDate,
        ToDate,
        Reason
    )
VALUES
    (
        'Em01',        -- Emp_Id - varchar(5)
        4,         -- LeaveTaken - int
        GETDATE(), -- FromDate - date
        GETDATE()+10, -- ToDate - date
        'Random'         -- Reason - varchar(50)
    )
GO

/*
	8. Create a trigger tgUpdateEmploee for table tbEmployeeDetails which removes the
	employee if new salary is reset to zero.
*/
CREATE TRIGGER tgUpdateEmployee
ON dbo.tbEmpDetail
AFTER UPDATE AS
BEGIN
	DECLARE @luong MONEY 
	DECLARE @manv VARCHAR(5)
	SELECT @manv=Inserted.Emp_Id,@luong=Inserted.Salary FROM Inserted	
		IF @luong=0 
		BEGIN
			DELETE FROM dbo.tbLeaveDetails WHERE Emp_Id=@manv
			DELETE FROM dbo.tbEmpDetail WHERE Emp_Id=@manv
			PRINT N'Đã xóa nhân viên vì lương = 0'
        END 		
END 
GO 


--Thêm dữ liệu để chút xóa
SELECT * FROM dbo.tbEmpDetail 
GO 

INSERT dbo.tbEmpDetail
    (
        Emp_Id,
        FullName,
        PhoneNumber,
        Designation,
        Salary,
        Join_Date
    )
VALUES
    (
        'Em06',       -- Emp_Id - varchar(5)
        'Cha Biet Ten Gi',       -- FullName - varchar(30)
        '01234567',       -- PhoneNumber - varchar(20)
        'Staff',       -- Designation - varchar(30)
        1500,     -- Salary - money
        GETDATE() -- Join_Date - date
    )
GO 

INSERT dbo.tbLeaveDetails
    (
        Emp_Id,
        LeaveTaken,
        FromDate,
        ToDate,
        Reason
    )
VALUES
    (
        'Em06',        -- Emp_Id - varchar(5)
        12,         -- LeaveTaken - int
        GETDATE(), -- FromDate - date
        GETDATE()+12, -- ToDate - date
        'Cha biet ly do gi'         -- Reason - varchar(50)
    )
GO 

--Kiểm tra trigger
UPDATE dbo.tbEmpDetail SET Salary=0 WHERE Emp_Id='Em06'
GO 

SELECT * FROM dbo.tbEmpDetail 
GO 