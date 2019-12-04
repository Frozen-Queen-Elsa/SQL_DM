CREATE DATABASE Ass5_db
ON	
( NAME='Ass5',FILENAME='D:\Study\Aptech\Season1\SQL\Database\Ass5.mdf',
  SIZE=5,FILEGROWTH=10%,MAXSIZE=5
)
LOG ON	
( NAME='Ass5_lg',FILENAME='D:\Study\Aptech\Season1\SQL\Database\Ass5_lg.ldf',
  SIZE=2,FILEGROWTH=10%,MAXSIZE=2
)
GO

USE Ass5_db
GO 

CREATE TABLE tbCustomer
(
	CUSTID VARCHAR(5) NOT NULL PRIMARY KEY,
	FullName VARCHAR(30) NOT NULL,
	[Address] VARCHAR(60) ,
	Phone VARCHAR(15) 
)
GO

CREATE TABLE tbCategory
(
	CATID VARCHAR(5) NOT NULL PRIMARY KEY,
	CatName VARCHAR(30) NOT NULL
)
GO 

CREATE TABLE tbProduct
(
	PROID VARCHAR(5) NOT NULL PRIMARY KEY,
	ProName VARCHAR(30) NOT NULL,
	UnitPrice float CHECK(UnitPrice BETWEEN 1 AND 200) NOT NULL,
	Unit VARCHAR(10),
	CATID VARCHAR(5) NOT NULL FOREIGN KEY REFERENCES dbo.tbCategory(CATID)
)

CREATE TABLE tbOrder
(
	ORDERID INT IDENTITY(300,1) PRIMARY KEY,
	OrderDate DATE DEFAULT GETDATE(),
	Comment VARCHAR(100),
	CUSID VARCHAR(5) NOT NULL FOREIGN KEY REFERENCES dbo.tbCustomer(CUSTID)
)

CREATE TABLE tbOrderDetail
(
	ORDERID INT NOT NULL FOREIGN KEY REFERENCES dbo.tbOrder(ORDERID),
	PROID VARCHAR(5) NOT NULL FOREIGN KEY REFERENCES dbo.tbProduct(PROID),
	Quantity SMALLINT DEFAULT 1 ,
	PRIMARY KEY (ORDERID,PROID)
)
GO 

INSERT dbo.tbCustomer
    (
        CUSTID,
        FullName,
        Address,
        Phone
    )
VALUES
    (
        'C01', -- CUSTID - varchar(5)
        'Lyly Tran', -- FullName - varchar(30)
        'No Trang Long', -- Address - varchar(60)
        '113'  -- Phone - varchar(15)
    ),
    (
        'C02', -- CUSTID - varchar(5)
        'Alex Pham', -- FullName - varchar(30)
        'Nguyen Trai', -- Address - varchar(60)
        '911'  -- Phone - varchar(15)
    ),
    (
        'C03', -- CUSTID - varchar(5)
        'Rose Nguyen', -- FullName - varchar(30)
        'Pham Ngu lao', -- Address - varchar(60)
        '1080'  -- Phone - varchar(15)
    ),		  
    (
        'C04', -- CUSTID - varchar(5)
        'Alan Pham', -- FullName - varchar(30)
        'Nguyen Tri Phuong', -- Address - varchar(60)
        '118'  -- Phone - varchar(15)
    )
GO 

INSERT dbo.tbCategory
    (
        CATID,
        CatName
    )
VALUES
    (
        'FO', -- CATID - varchar(5)
        'Food'  -- CatName - varchar(30)
    ),	
    (
        'BE', -- CATID - varchar(5)
        'Beverage'  -- CatName - varchar(30)
    ), 
    (
        'OT', -- CATID - varchar(5)
        'Other'  -- CatName - varchar(30)
    )
GO 

INSERT dbo.tbProduct
    (
        PROID,
        ProName,
        UnitPrice,
        Unit,
        CATID
    )
VALUES
    (
        'P01',  -- PROID - varchar(5)
        'Coca Cola',  -- ProName - varchar(30)
        2.5, -- UnitPrice - float
        'can',  -- Unit - varchar(10)
        'BE'   -- CATID - varchar(5)
    ),	   
    (
        'P02',  -- PROID - varchar(5)
        'Beer 333',  -- ProName - varchar(30)
        4, -- UnitPrice - float
        'can',  -- Unit - varchar(10)
        'BE'   -- CATID - varchar(5)
    ), 
    (
        'P03',  -- PROID - varchar(5)
        'Chocolate',  -- ProName - varchar(30)
        9, -- UnitPrice - float
        'pack',  -- Unit - varchar(10)
        'FO'   -- CATID - varchar(5)
    ),	  
    (
        'P04',  -- PROID - varchar(5)
        'Chocolate Cake',  -- ProName - varchar(30)
        4, -- UnitPrice - float
        'pack',  -- Unit - varchar(10)
        'FO'   -- CATID - varchar(5)
    ),		   
    (
        'P05',  -- PROID - varchar(5)
        'Cheese',  -- ProName - varchar(30)
        10, -- UnitPrice - float
        'pack',  -- Unit - varchar(10)
        'FO'   -- CATID - varchar(5)
    ),	
    (
        'P06',  -- PROID - varchar(5)
        'Sampoo',  -- ProName - varchar(30)
        8, -- UnitPrice - float
        'bottle',  -- Unit - varchar(10)
        'OT'   -- CATID - varchar(5)
    )
GO 

INSERT dbo.tbOrder
    (
        OrderDate,
        Comment,
        CUSID
    )
VALUES
    (
        '20140830', -- OrderDate - date
        'Nothing',        -- Comment - varchar(100)
        'C01'         -- CUSID - varchar(5)
    ),
    (
        '20141031', -- OrderDate - date
        'Nothing',        -- Comment - varchar(100)
        'C01'         -- CUSID - varchar(5)
    ),	 
    (
        '20141107', -- OrderDate - date
        'Nothing',        -- Comment - varchar(100)
        'C03'         -- CUSID - varchar(5)
    ),	
    (
        '20141107', -- OrderDate - date
        'Nothing',        -- Comment - varchar(100)
        'C02'         -- CUSID - varchar(5)
    )
GO 

INSERT dbo.tbOrderDetail
    (
        ORDERID,
        PROID,
        Quantity
    )
VALUES
    (
        300,  -- ORDERID - int
        'P01', -- PROID - varchar(5)
        3   -- Quantity - smallint
    ), 	
    (
        300,  -- ORDERID - int
        'P03', -- PROID - varchar(5)
        1   -- Quantity - smallint
    ),	 
    (
        301,  -- ORDERID - int
        'P02', -- PROID - varchar(5)
        8   -- Quantity - smallint
    ),	
    (
        301,  -- ORDERID - int
        'P03', -- PROID - varchar(5)
        1   -- Quantity - smallint
    ),	  
    (
        301,  -- ORDERID - int
        'P05', -- PROID - varchar(5)
        15   -- Quantity - smallint
    ),	
    (
        302,  -- ORDERID - int
        'P06', -- PROID - varchar(5)
        5   -- Quantity - smallint
    ), 
    (
        303,  -- ORDERID - int
        'P02', -- PROID - varchar(5)
        4   -- Quantity - smallint
    )
GO 

--4a
SELECT * FROM dbo.tbCustomer
GO

--4b
SELECT * FROM dbo.tbProduct
ORDER BY UnitPrice
GO 

--4c
SELECT * FROM dbo.tbOrder
SELECT * FROM dbo.tbCustomer
SELECT * FROM dbo.tbProduct
SELECT * FROM dbo.tbOrderDetail
GO 

SELECT c.ORDERID,c.OrderDate,d.FullName,b.ProName,a.Quantity,b.Unit,b.UnitPrice,a.Quantity * b.UnitPrice AS Amount
FROM 
(dbo.tbOrderDetail a JOIN dbo.tbProduct b ON a.PROID=b.PROID) JOIN (dbo.tbOrder c JOIN dbo.tbCustomer d ON c.CUSID=d.CUSTID) ON a.ORDERID=c.ORDERID 
GO 

--4d Cach 1
SELECT *
FROM dbo.tbProduct
WHERE CATID = 'FO'
GO 

--4d Cach 2
SELECT * 
FROM dbo.tbProduct
WHERE CATID IN (SELECT CATID FROM dbo.tbCategory WHERE CatName = 'Food') 
GO 

--4e
SELECT CATID, COUNT(*) AS [Total Quantity]
FROM dbo.tbProduct 
GROUP BY CATID
GO 

--4e đầy đủ
SELECT b.CATID,b.CatName, COUNT(*)
FROM dbo.tbProduct a JOIN dbo.tbCategory b ON a.CATID=b.CATID
GROUP BY b.CATID,b.CatName
GO 

--4f
SELECT *
FROM dbo.tbOrderDetail
WHERE ORDERID = 302	
go

--4g
SELECT *
FROM dbo.tbOrderDetail 
WHERE Quantity >2 
GO 

--4h
SELECT * 
FROM dbo.tbOrderDetail
ORDER BY PROID
GO

SELECT PROID,SUM(Quantity) as [Total Quantity]
FROM dbo.tbOrderDetail
GROUP BY PROID
ORDER BY [Total Quantity] desc
GO 

SELECT TOP 2 WITH TIES PROID,SUM(Quantity) as [Total Quantity]
FROM dbo.tbOrderDetail
GROUP BY PROID
ORDER BY [Total Quantity] desc
GO 

