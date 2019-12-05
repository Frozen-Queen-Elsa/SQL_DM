
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

CREATE CLUSTERED INDEX ixDesc ON dbo.tbItem(ItemDesc DESC)
GO 

/*
	5. Perform the following queries on the above table
		a. Display the details of Item table
		b. Display a stock report showing item code, description, quantity on hand, re-order level and price giving user friendly names to the columns.
		c. Display the details of items having a price less than or equal to 2000
		d. Write a query to display an item issue report showing issue code, issue date, department code, item description and quantity issued
*/

--5a. Display the details of Item table

SELECT * FROM dbo.tbItem
GO 

--5b. Display a stock report showing item code, description, quantity on hand, re-order level and price giving user		friendly names to the columns.

SELECT ItemCode AS [Item Code],ItemDesc AS [Description], Qoh AS [Quantity on hand],ReOrdLvl AS [Re-Order Level],Price
FROM dbo.tbItem 
GO  

--5c. Display the details of items having a price less than or equal to 2000

SELECT ItemCode AS [Item Code],ItemDesc AS [Description], Qoh AS [Quantity on hand],ReOrdLvl AS [Re-Order Level],Price
FROM dbo.tbItem
WHERE Price<=2000
GO 

--5d. Write a query to display an item issue report showing issue code, issue date, department code, item description	and quantity issued

SELECT a.IssueCode,a.IssueDate,a.DeptCode,c.ItemDesc,b.IssueQty
FROM (dbo.tbIssueMaster a JOIN dbo.tbIssueDetails b ON b.IssueCode = a.IssueCode) JOIN dbo.tbItem c ON b.ItemCode=c.ItemCode
GO 

/*
	6. Create a view vwQoH display a list of items where the quantity on hand is equal to the re-order level
*/
CREATE VIEW vwQoH
AS
SELECT *
FROM dbo.tbItem 
WHERE Qoh=ReOrdLvl
GO 

SELECT * FROM dbo.vwQoH
GO 

/*
	7. Create a store procedure named uspIncreaseQOH to increase the quantity on hand of a given item code.
	Hint: The procedure accept two parameters: itemcode and amount to be added to QOH column in Item table
*/

CREATE PROC uspIncreaseQOH
@ma_item VARCHAR(5),@soluong INT
AS
BEGIN
	--Bước 1 : Hiện bảng theo yêu cầu
	SELECT * 
	FROM dbo.tbItem
	WHERE ItemCode=@ma_item ;
	--Bước 2 : Update dữ liệu
	UPDATE dbo.tbItem SET Qoh+=@soluong WHERE ItemCode=@ma_item ;
	--Bước 3 : Hiện bảng theo yêu cầu	
	SELECT * 
	FROM dbo.tbItem
	WHERE ItemCode=@ma_item ; 	 
END
GO 

--Thử store với Item IT001 thêm 10Qoh
EXEC dbo.uspIncreaseQOH
    @ma_item = 'IT001', -- varchar(5)
    @soluong = 10   -- int
GO 

/*
	8. Create a trigger for tgIssueDetails table which will perform the following task when a new record is inserted:
		a. Ensure that the quantity issued is less than or equal to quantity on hand
		b. Update the Qoh column of Item table by subtracting the quantity issued
*/


CREATE TRIGGER tgIssueDetails
ON dbo.tbIssueDetails
FOR INSERT AS 
BEGIN 
	DECLARE @soluong_issue INT , @soluong_item INT  
	SELECT @soluong_issue = a.IssueQty FROM Inserted a ;
	SELECT @soluong_item = b.Qoh FROM dbo.tbItem b;
	-- 8a.Ensure that the quantity issued is less than or equal to quantity on hand
	IF @soluong_issue > @soluong_item 
	BEGIN
	    PRINT N'Số lượng hàng bị lỗi phải ít hơn hoặc bằng số lượng hàng đang có'
		ROLLBACK
	END	
	-- 8b. Update the Qoh column of Item table by subtracting the quantity issued
	--(Cập nhật là cột Qoh của bảng Item bằng cách trừ đi số lượng bị lỗi)
	UPDATE dbo.tbItem 
	SET Qoh -= @soluong_issue
	FROM dbo.tbItem a JOIN Inserted b ON b.ItemCode = a.ItemCode
END 

GO 

--Test Trigger kiểm tra Insert IT004 có IssueQty = 500 có thông báo lỗi không !!
SELECT * FROM dbo.tbIssueDetails
SELECT * FROM dbo.tbItem
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
        'IT004', -- ItemCode - varchar(5)
        500   -- IssueQty - int
    )
GO 

--Test Trigger kiểm tra Insert IT004 có IssueQty = 10 thì bên bảng Item có update Qoh không ?
INSERT dbo.tbIssueDetails
    (
        IssueCode,
        ItemCode,
        IssueQty
    )
VALUES
    (
        'IS1001', -- IssueCode - varchar(5)
        'IT1004', -- ItemCode - varchar(5)
        10   -- IssueQty - int
    )
GO 

SELECT * FROM dbo.tbIssueDetails
SELECT * FROM dbo.tbItem
GO 




