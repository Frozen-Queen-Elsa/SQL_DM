
-- 1. Create a database named Ass11
CREATE DATABASE dbAss11
GO 

USE dbAss11
GO 

-- 2. Create the following tables in the database, applying the specified integrity constraints
CREATE TABLE tbItem
( 
	ItemCode VARCHAR(5) PRIMARY KEY NONCLUSTERED,
	ItemDesc VARCHAR(30) NOT NULL,
	Qoh INT NOT NULL ,					--Quantity on hand
	ReOrdLvl INT ,						--Re-order level
	Price INT							--Price per unit
)
GO 

CREATE TABLE tbIssueMaster
(
	IssueCode VARCHAR(5) PRIMARY KEY,
	IssueDate DATE NOT NULL,
	DeptCode VARCHAR(5) NOT NULL
)
GO 

CREATE TABLE tbIssueDetails
(
	IssueCode VARCHAR(5) FOREIGN KEY REFERENCES dbo.tbIssueMaster(IssueCode) ,
	ItemCode VARCHAR(5) FOREIGN KEY REFERENCES dbo.tbItem(ItemCode),
	IssueQty INT	--Quantity issued
	PRIMARY KEY (IssueCode,ItemCode)
)
GO 

-- 3. Insert the following data into the above tables:
INSERT dbo.tbItem
    (
        ItemCode,
        ItemDesc,
        Qoh,
        ReOrdLvl,
        Price
    )
VALUES
    (
        'IT001', -- ItemCode - varchar(5)
        'Refrigerator', -- ItemDesc - varchar(30)
        50,  -- Qoh - int
        400,  -- ReOrdLvl - int
        4000   -- Price - int
    ),
    (
        'IT002', -- ItemCode - varchar(5)
        'Television', -- ItemDesc - varchar(30)
        100,  -- Qoh - int
        75,  -- ReOrdLvl - int
        3000   -- Price - int
    ),
    (
        'IT003', -- ItemCode - varchar(5)
        'Washing Machine', -- ItemDesc - varchar(30)
        250,  -- Qoh - int
        250,  -- ReOrdLvl - int
        2000   -- Price - int
    ),
    (
        'IT004', -- ItemCode - varchar(5)
        'Microware', -- ItemDesc - varchar(30)
        200,  -- Qoh - int
        150,  -- ReOrdLvl - int
        3500   -- Price - int
    )
GO 

INSERT dbo.tbIssueMaster
    (
        IssueCode,
        IssueDate,
        DeptCode
    )
VALUES
    (
        'IS001',        -- IssueCode - varchar(5)
        '20030112', -- IssueDate - date
        'D0001'         -- DeptCode - varchar(5)
    ),
    (
        'IS002',        -- IssueCode - varchar(5)
        '20030218', -- IssueDate - date
        'D0003'         -- DeptCode - varchar(5)
    ),
    (
        'IS003',        -- IssueCode - varchar(5)
        '20030218', -- IssueDate - date
        'D0008'         -- DeptCode - varchar(5)
    ),
    (
        'IS004',        -- IssueCode - varchar(5)
        '20030815', -- IssueDate - date
        'D0002'         -- DeptCode - varchar(5)
    )
GO 

INSERT dbo.tbIssueDetails
    (
        IssueCode,
        ItemCode,
        IssueQty
    )
VALUES
    (
        'IS001', -- IssueCode - varchar(5)
        'IT001', -- ItemCode - varchar(5)
        15   -- IssueQty - int
    ),
    (
        'IS002', -- IssueCode - varchar(5)
        'IT003', -- ItemCode - varchar(5)
        5   -- IssueQty - int
    ),
    (
        'IS003', -- IssueCode - varchar(5)
        'IT004', -- ItemCode - varchar(5)
        2   -- IssueQty - int
    ),
    (
        'IS004', -- IssueCode - varchar(5)
        'IT002', -- ItemCode - varchar(5)
        1   -- IssueQty - int
    ),
    (
        'IS005', -- IssueCode - varchar(5)
        'IT004', -- ItemCode - varchar(5)
        5   -- IssueQty - int
    )
GO 

-- 4. Create clustered index ixDesc on column ItemDesc of table tbItem, by descending order.

CREATE CLUSTERED INDEX ixDesc ON dbo.tbItem(ItemDesc)
GO 