-- Asignment 12
-- 1. Tạo CSDL “Kinhdoanh”
CREATE DATABASE dbKinhDoanh
GO 

USE dbKinhDoanh
GO 

/*
	2. Tạo các bảng sau:
	a. DMNSX (MANSX varchar(2) PK, TENNSX nvarchar(40), THANHPHO nvarchar(40), PHONE int unique)
	b. HANGHOA (MAHH varchar(4) PK, TENHH nvarchar(40), MANSX varchar(2) FK, SL int default 10,DONGIA int DONGIA > 100
	c. Add thêm vào DMNSX 1 field có tên là EMAIL varchar(30).
	d. Add thêm vào HANGHOA 1 field có tên là NGAYNH datetime. NGAYNH <= ngày hiện tại
*/
CREATE TABLE DMNSX
(
	MaNSX VARCHAR(2) PRIMARY KEY NONCLUSTERED,
	TenNSX NVARCHAR(40) NOT NULL,
	ThanhPho NVARCHAR(40) ,
	Phone INT UNIQUE
)
GO 

CREATE TABLE HangHoa
(
	MaHH VARCHAR(4) PRIMARY KEY NONCLUSTERED,
	TenHH NVARCHAR(40) NOT NULL,
	MaNSX VARCHAR(2) FOREIGN KEY REFERENCES dbo.DMNSX(MaNSX),
	SL INT DEFAULT 10,
	DonGia INT CHECK(DonGia>100)
)
GO 

/*
	Note Lệnh Alter :
	1. ALTER TABLE table_name ADD column_name datatype;					--thêm một cột mới trong một bảng hiện có

	2. ALTER TABLE table_name DROP COLUMN column_name;					--DROP COLUMN trong một bảng hiện có

	3. ALTER TABLE table_name MODIFY COLUMN column_name datatype;		--thay đổi DATA TYPE của một cột 

	4. ALTER TABLE table_name											--thêm UNIQUE CONSTRAINT vào một bảng 
		ADD CONSTRAINT MyUniqueConstraint UNIQUE(column1, column2...);

	5. ADD CONSTRAINT MyUniqueConstraint CHECK (CONDITION);				--thêm CHECK CONSTRAINT vào một bảng 

	6. ALTER TABLE table_name											--thêm ràng buộc PRIMARY KEY vào một bảng
		ADD CONSTRAINT MyPrimaryKey PRIMARY KEY (column1, column2...);

	7. ALTER TABLE table_name											--DROP CONSTRAINT từ một bảng 
		DROP CONSTRAINT MyUniqueConstraint;

	8. ALTER TABLE table_name											--DROP PRIMARY KEY từ một bảng
		DROP CONSTRAINT MyPrimaryKey;
*/

ALTER TABLE DMNSX ADD Email VARCHAR(30)
GO 
ALTER TABLE HangHoa ADD NgayNH DATE CHECK(NgayNH<=GETDATE())
GO 

/*
	3. Chèn các mẫu tin sau vào các bảng:
*/
INSERT dbo.DMNSX
    (
        MaNSX,
        TenNSX,
        ThanhPho,
        Phone,
		Email
    )
VALUES
    (
        'NK',  -- MaNSX - varchar(2)
        N'Nokia', -- TenNSX - nvarchar(40)
        N'Sài Gòn', -- ThanhPho - nvarchar(40)
        0993111111,    -- Phone - int
		'nokia@yaho.com'
    ),
    (
        'SS',  -- MaNSX - varchar(2)
        N'Samsung', -- TenNSX - nvarchar(40)
        N'Cần Thơ', -- ThanhPho - nvarchar(40)
        0993111112,   -- Phone - int
		'samsung@yaho.com'
    ),
    (
        'MT',  -- MaNSX - varchar(2)
        N'Motorala', -- TenNSX - nvarchar(40)
        N'Hà Nội', -- ThanhPho - nvarchar(40)
        0993111113,    -- Phone - int
		'motorala@yaho.com'
    ),
    (
        'LG',  -- MaNSX - varchar(2)
        N'LG', -- TenNSX - nvarchar(40)
        N'Sài Gòn', -- ThanhPho - nvarchar(40)
        0993111114,    -- Phone - int
		'lg@yaho.com'
    ),
    (
        'SM',  -- MaNSX - varchar(2)
        N'Seimens', -- TenNSX - nvarchar(40)
        N'Hà Nội', -- ThanhPho - nvarchar(40)
        0993111115,    -- Phone - int
		'seimens@yaho.com'
    )
GO 

INSERT dbo.HangHoa
    (
        MaHH,
        TenHH,
        MaNSX,
        SL,
        DonGia,
		NgayNH
    )
VALUES
    (
        'NK01',  -- MaHH - varchar(4)
        N'Nokia 6630', -- TenHH - nvarchar(40)
        'NK',  -- MaNSX - varchar(2)
        20,   -- SL - int
        1000 ,   -- DonGia - int
		'20161220'		--NgayNH -date
    ),
    (
        'SS01',  -- MaHH - varchar(4)
        N'Samsung 1170', -- TenHH - nvarchar(40)
        'SS',  -- MaNSX - varchar(2)
        50,   -- SL - int
        800 ,   -- DonGia - int
		'20160101'		--NgayNH -date
    ),
    (
        'MT01',  -- MaHH - varchar(4)
        N'Motorola 7732', -- TenHH - nvarchar(40)
        'MT',  -- MaNSX - varchar(2)
        35,   -- SL - int
        4000 ,   -- DonGia - int
		'20160105'		--NgayNH -date
    ),
    (
        'NK02',  -- MaHH - varchar(4)
        N'Nokia 7700', -- TenHH - nvarchar(40)
        'NK',  -- MaNSX - varchar(2)
        60,   -- SL - int
        1200 ,   -- DonGia - int
		'20170110'		--NgayNH -date
    ),
    (
        'LG01',  -- MaHH - varchar(4)
        N'LG 2009', -- TenHH - nvarchar(40)
        'LG',  -- MaNSX - varchar(2)
        40,   -- SL - int
        2000 ,   -- DonGia - int
		'20171223'		--NgayNH -date
    ),
    (
        'SS02',  -- MaHH - varchar(4)
        N'Samsung 7800', -- TenHH - nvarchar(40)
        'SS',  -- MaNSX - varchar(2)
        30,   -- SL - int
        3000 ,   -- DonGia - int
		'20170111'		--NgayNH -date
    ),
    (
        'SS03',  -- MaHH - varchar(4)
        N'Samsung 9000', -- TenHH - nvarchar(40)
        'SS',  -- MaNSX - varchar(2)
        15,   -- SL - int
        4500 ,   -- DonGia - int
		'20171120'		--NgayNH -date
    ),
    (
        'NK03',  -- MaHH - varchar(4)
        N'Nokia 2009', -- TenHH - nvarchar(40)
        'NK',  -- MaNSX - varchar(2)
        40,   -- SL - int
        5000 ,   -- DonGia - int
		'20160113'		--NgayNH -date
    ),
    (
        'SM01',  -- MaHH - varchar(4)
        N'Seamens 6677', -- TenHH - nvarchar(40)
        'SM',  -- MaNSX - varchar(2)
        50,   -- SL - int
        1300 ,   -- DonGia - int
		'20170102'		--NgayNH -date
    ),
    (
        'SM03',  -- MaHH - varchar(4)
        N'Seamens 776', -- TenHH - nvarchar(40)
        'SM',  -- MaNSX - varchar(2)
        35,   -- SL - int
        5500 ,   -- DonGia - int
		'20180107'		--NgayNH -date
    )
GO 


/*
	4. Tạo non-clustered index trên cột TENNSX
	5. Tạo clustered index trên cột TENHH theo thứ tự giảm dần từ Z-A
*/
CREATE NONCLUSTERED INDEX ixNSX ON dbo.DMNSX(TenNSX)
GO 
CREATE CLUSTERED INDEX ixHH ON dbo.HangHoa(TenHH DESC)
GO 

/*
	6. Viết lịnh truy vấn :
	a. Liệt kê các mặt hàng thuộc nhà sản xuất Nokia.
	b. Liệt kê các mặt hàng có MAHH bắt đầu bằn ký tự ‘S’ và kết thúc bằng ký tự ‘1’.
	c. Liệt kê tất cả các mặt hàng nhập trong tháng 1/2016.
	d. Liệt kê các mặt hàng của Samsung có giá từ 500 đến 2000.
	e. Đếm xem mỗi NSX có bao nhiêu mặt hàng. Kết quả xuất hiện 2 cột: MANSX và SOLUONG (cột tự tạo chứa số mặt hàng ứng với mỗi NSX). Sử dụng Group By.
	f. Tính tổng doanh số của từng nhà San xuat. Kết quả hiện 2 cột MANSX và THANHTIEN. Cột tự tạo từ SL*DONGIA. Sử dụng Group By và hàm Sum().
*/

--6a. Liệt kê các mặt hàng thuộc nhà sản xuất Nokia.
SELECT *
FROM dbo.HangHoa
WHERE MaNSX='NK'
GO 

--6b. Liệt kê các mặt hàng có MAHH bắt đầu bằn ký tự ‘S’ và kết thúc bằng ký tự ‘1’.
SELECT *
FROM dbo.HangHoa
WHERE MaHH LIKE 'S%1'
GO 

--6c. Liệt kê tất cả các mặt hàng nhập trong tháng 1/2016
SELECT *
FROM dbo.HangHoa
WHERE MONTH(NgayNH)=1 AND YEAR(NgayNH)=2016
GO 

--6d. Liệt kê các mặt hàng của Samsung có giá từ 500 đến 2000.
SELECT *
FROM dbo.HangHoa
WHERE MaNSX='SS' AND DonGia BETWEEN 500 AND 2000
GO 

--6e. Đếm xem mỗi NSX có bao nhiêu mặt hàng. Kết quả xuất hiện 2 cột: MANSX và SOLUONG (cột tự tạo chứa số mặt hàng ứng với mỗi NSX). Sử dụng Group By.
SELECT MaNSX,COUNT(*) AS [SOLUONG]
FROM dbo.HangHoa
GROUP BY MaNSX
GO 

--6f. Tính tổng doanh số của từng nhà San xuat. Kết quả hiện 2 cột MANSX và THANHTIEN. Cột tự tạo từ SL*DONGIA. Sử	dụng Group By và hàm Sum().
SELECT *
FROM dbo.HangHoa
GO 

SELECT MaNSX, SUM(SL*DonGia) AS [THANHTIEN]
FROM dbo.HangHoa
GROUP BY MaNSX
GO 

--7. Tạo view vwNSX liệt kê tất cả các NSX không ở thành phố “Sài Gòn”.
CREATE VIEW vwNSX
AS
SELECT *
FROM dbo.DMNSX
WHERE ThanhPho != N'Sài Gòn'
GO 

SELECT * FROM dbo.vwNSX
GO 

/*
	8. Tạo stored procedure tên uspDONGIA, thực hiện các tác vụ sau
	a. In danh sách các sản phẩm
	b. Tăng đồng loạt đơn giá của các sản phẩm có đơn giá dưới 2,000 lên thêm x đồng (với x là tham số của store – mặc định là 100)
	c. In ra số sản phẩm đã được tăng giá
	d. In lại danh sách các sản phẩm sau khi tang giá
*/
CREATE PROC uspDongGia
@x INT ,@sodong INT OUTPUT
AS
BEGIN 
	--Lệnh 1 :
	SELECT *
	FROM dbo.HangHoa	;
	--Lệnh 2 :
	UPDATE dbo.HangHoa
	SET DonGia+=@x
	WHERE DonGia<2000 ;
	--Lệnh 3 : 
	SET @sodong =@@ROWCOUNT
	--Lệnh 4 :
	SELECT *
	FROM dbo.HangHoa
END
GO 

DECLARE @soKQ INT;
EXEC dbo.uspDongGia
    @x = 100,                  -- int
    @sodong = @soKQ OUTPUT -- int
SELECT @soKQ AS N'Số lượng sản phẩm đã thay đổi'
GO 

/*
	9. Viết trigger tgTENNSX cấm đổi tên nhà sản xuất
*/
CREATE TRIGGER tgTenNSX
ON dbo.DMNSX
FOR UPDATE AS 
BEGIN 
	IF UPDATE(TenNSX)
	BEGIN
		PRINT N'Bạn không thể đổi tên của Nhà Sản Xuất'
		ROLLBACK 
	END    
END
GO 

--Kiểm tra trigger update NSX SamSung > Apple xem có báo lỗi không
UPDATE dbo.DMNSX SET TenNSX='Apple' WHERE TenNSX='SamSung'
GO 

/*
	10. Viết trigger tgTENHH, không cho phép tên hàng hóa ít hơn 3 ký tự.
*/
CREATE TRIGGER tgTenHH
ON dbo.HangHoa
INSTEAD OF INSERT,Update AS 
BEGIN
	IF (SELECT LEN(Inserted.TenHH) FROM Inserted )<3
	BEGIN
		PRINT N'Tên hàng hóa không thể ít hơn 3 ký tự'
		ROLLBACK
    END 
END
GO 

--Kiểm tra Trigger = lệnh Insert
INSERT dbo.HangHoa
    (
        MaHH,
        TenHH,
        MaNSX,
        SL,
        DonGia
    )
VALUES
    (
        'LG03',  -- MaHH - varchar(4)
        N'LG', -- TenHH - nvarchar(40)
        'LG',  -- MaNSX - varchar(2)
        10,   -- SL - int
        1000    -- DonGia - int
    )
GO 

--Kiểm tra Trigger = lệnh Update
UPDATE dbo.HangHoa SET TenHH='LG' WHERE MaNSX='LG'
GO 