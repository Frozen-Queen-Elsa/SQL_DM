--Asignment 08
--1. Tạo database tên ASS7b
CREATE DATABASE ASS7b
GO 

USE ASS7b 
GO 

--2. Tạo các bảng trong database với mô tả sau :
CREATE TABLE tbKhachHang
(
	MaKH VARCHAR(5) PRIMARY KEY,
	HoTen NVARCHAR(40) NOT NULL,
	DiaChi Nvarchar(60) 
)
GO 

CREATE TABLE tbMatHang
(
	MaMH VARCHAR(5) PRIMARY KEY,
	TenMH NVARCHAR(30) NOT NULL,
	DonViTinh NVARCHAR(20) NOT NULL,
	DonGia INT NOT NULL
)
GO 

CREATE TABLE tbDonHang
(
	MaDH INT IDENTITY(1,1) PRIMARY KEY,
	MaKH VARCHAR(5) FOREIGN KEY REFERENCES dbo.tbKhachHang(MaKH),
	NgayDat DATE DEFAULT GETDATE(),
	DaThanhToan BIT   --bit – 0: chưa thanh toán, 1 : đã thanh toán
)
GO 

CREATE TABLE tbCTDonHang
(
	MaDH INT FOREIGN KEY REFERENCES dbo.tbDonHang(MaDH),
	MaMH VARCHAR(5) FOREIGN KEY REFERENCES dbo.tbMatHang(MaMH),
	SoLuong SMALLINT
	PRIMARY KEY(MaDH,MaMH)
)
GO 

INSERT dbo.tbKhachHang
    (
        MaKH,
        HoTen,
        DiaChi
    )
VALUES
    (
        'C01',  -- MaKH - varchar(5)
        N'An An', -- HoTen - nvarchar(40)
        N'Nguyễn Huệ'  -- DiaChi - nvarchar(60)
    ),
    (
        'C02',  -- MaKH - varchar(5)
        N'Bảo Bảo', -- HoTen - nvarchar(40)
        N'Phạm Ngũ Lão'  -- DiaChi - nvarchar(60)
    ),
    (
        'C03',  -- MaKH - varchar(5)
        N'Kỳ Kỳ', -- HoTen - nvarchar(40)
        N'Lê Lợi'  -- DiaChi - nvarchar(60)
    )
GO 

INSERT dbo.tbMatHang
    (
        MaMH,
        TenMH,
        DonViTinh,
        DonGia
    )
VALUES
    (
        'P01',  -- MaMH - varchar(5)
        N'Coca Cola', -- TenMH - nvarchar(30)
        N'Lon', -- DonViTinh - nvarchar(20)
        2    -- DonGia - int
    ),
    (
        'P02',  -- MaMH - varchar(5)
        N'Chocolate Cake', -- TenMH - nvarchar(30)
        N'Cái', -- DonViTinh - nvarchar(20)
        5    -- DonGia - int
    ),
    (
        'P03',  -- MaMH - varchar(5)
        N'Kẹo dẽo', -- TenMH - nvarchar(30)
        N'Gói', -- DonViTinh - nvarchar(20)
        3    -- DonGia - int
    ),
    (
        'P04',  -- MaMH - varchar(5)
        N'Đường', -- TenMH - nvarchar(30)
        N'Kg', -- DonViTinh - nvarchar(20)
        1.5    -- DonGia - int
    ),
    (
        'P05',  -- MaMH - varchar(5)
        N'Sữa', -- TenMH - nvarchar(30)
        N'Lon', -- DonViTinh - nvarchar(20)
        20    -- DonGia - int
    )
GO 

INSERT dbo.tbDonHang
    (
        MaKH,
        NgayDat,
        DaThanhToan
    )
VALUES
    (
        'C01',        -- MaKH - varchar(5)
        '20141015', -- NgayDat - date
        1       -- DaThanhToan - bit
    ),
    (
        'C01',        -- MaKH - varchar(5)
        '20141017', -- NgayDat - date
        0       -- DaThanhToan - bit
    ),
    (
        'C02',        -- MaKH - varchar(5)
        '20141112', -- NgayDat - date
        1       -- DaThanhToan - bit
    ),
    (
        'C03',        -- MaKH - varchar(5)
        '20141114', -- NgayDat - date
        0       -- DaThanhToan - bit
    ),
    (
        'C02',        -- MaKH - varchar(5)
        '20141010', -- NgayDat - date
        0       -- DaThanhToan - bit
    )
GO 

INSERT dbo.tbCTDonHang
    (
        MaDH,
        MaMH,
        SoLuong
    )
VALUES
    (
        1,  -- MaDH - int
        'P02', -- MaMH - varchar(5)
        5   -- SoLuong - smallint
    ),
    (
        1,  -- MaDH - int
        'P03', -- MaMH - varchar(5)
        1   -- SoLuong - smallint
    ),
    (
        2,  -- MaDH - int
        'P01', -- MaMH - varchar(5)
        10   -- SoLuong - smallint
    ),
    (
        3,  -- MaDH - int
        'P05', -- MaMH - varchar(5)
        2   -- SoLuong - smallint
    ),
    (
        3,  -- MaDH - int
        'P04', -- MaMH - varchar(5)
        2   -- SoLuong - smallint
    ),
    (
        3,  -- MaDH - int
        'P03', -- MaMH - varchar(5)
        1   -- SoLuong - smallint
    ),
    (
        4,  -- MaDH - int
        'P03', -- MaMH - varchar(5)
        2   -- SoLuong - smallint
    ),	
    (
        5,  -- MaDH - int
        'P01', -- MaMH - varchar(5)
        12   -- SoLuong - smallint
    ),
    (
        5,  -- MaDH - int
        'P03', -- MaMH - varchar(5)
        3   -- SoLuong - smallint
    )
GO 

-- b) Hiển thị các Don Hang đã quá 1 năm so với ngày hiện hành
SELECT *
FROM dbo.tbDonHang
WHERE DATEDIFF(dd,NgayDat,GETDATE())>365
GO  

-- c) Xác định tên mặt hàng nào được đặt mua nhiều lần nhất
SELECT *
FROM dbo.tbCTDonHang
ORDER BY MaMH
GO 

SELECT MaMH,SUM(SoLuong) AS N'Tổng số đặt hàng'
FROM dbo.tbCTDonHang
GROUP BY MaMH 
ORDER BY SUM(SoLuong) desc
GO 

-- d) Tạo view vwDH để liệt kê các DON HANG chưa thanh toán trên 30 ngày so với ngày hiện hành
CREATE VIEW vwDH
AS 
SELECT *
FROM dbo.tbDonHang
WHERE DaThanhToan =0 AND DATEDIFF(dd,NgayDat,GETDATE())>30
GO 

SELECT * FROM dbo.vwDH
GO

-- e) Tạo 1 Stored procedure uspKH nhận tham số input @hoten là tên khách hàng, liệt kê chi tiết các thông tin về các đơn hàng của khách hàng này.
SELECT *
FROM dbo.tbCTDonHang
GO 

SELECT *
FROM dbo.tbDonHang
GO 
 a.MaKH,a.HoTen,a.DiaChi,b.MaDH,c.MaMH,c.TenMH,
CREATE PROCEDURE uspKH
@hoten NVARCHAR(40)
AS 
BEGIN 
	SELECT*
	FROM (dbo.tbKhachHang a JOIN ((dbo.tbCTDonHang b JOIN dbo.tbMatHang c ON c.MaMH = b.MaMH) JOIN dbo.tbDonHang d ON d.MaDH = b.MaDH) ON b.MaKH = a.MaKH)
	WHERE a.HoTen=@hoten ;	
END 
GO 

EXEC dbo.uspKH
    @hoten = N'An An' -- nvarchar(40)
GO 
 