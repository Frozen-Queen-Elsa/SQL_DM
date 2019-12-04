-- Assignment 9 – SQL2012 - Trigger
-- 1. Tạo database tên ASS9
CREATE DATABASE dbASS9
GO 

USE dbASS9
GO 

-- 2. Tạo các bảng trong database với mô tả sau :
--a. tbGIAOVIEN(MaGV , TenGV)
--b. tbHOCVIEN ( MaHV , Hoten , DiaChi )
--c. tbLOPHOC( Malop , Tenlop , Siso ,MaGV)
--Check constraint : siso >=10 và <=20
--d. tbDANGKY (MaHV, Malop, NgayDK, Ghi chu)
--▪ Tạo ràng buộc khoá ngoại giữa các bảng
--▪ Nhập 1 số data thích hơp ( bằng câu lệnh INSERT, mỗi bảng ít nhất 5 mẫu tin )

CREATE TABLE tbGiaoVien
(
	MaGV VARCHAR(5) PRIMARY KEY NONCLUSTERED,
	TenGv NVARCHAR(50) NOT NULL
)
GO 

CREATE TABLE tbHocVien
(
	MaHV VARCHAR(5) PRIMARY KEY NONCLUSTERED,
	HoTen NVARCHAR(50) NOT NULL,
	DiaChi NVARCHAR(60) NOT NULL
)
GO 

CREATE TABLE tbLopHoc
(
	MaLop VARCHAR(5) PRIMARY KEY NONCLUSTERED,
	TenLop NVARCHAR(30) NOT NULL,
	SiSo INT CHECK(SiSo>=10 AND SiSo<=20),
	MaGV VARCHAR(5) FOREIGN KEY REFERENCES dbo.tbGiaoVien(MaGV)
)
GO 

CREATE TABLE tbDangKy
(
	MaHV VARCHAR(5) FOREIGN KEY REFERENCES dbo.tbHocVien(MaHV),
	MaLop VARCHAR(5) FOREIGN KEY REFERENCES dbo.tbLopHoc(MaLop),
	NgayDK DATE DEFAULT GETDATE(),
	GhiChu VARCHAR(100) 
	PRIMARY KEY (MaHV,MaLop)
)
GO 

--Thêm dữ liệu cho bảng 
INSERT dbo.tbGiaoVien
    (
        MaGV,
        TenGv
    )
VALUES
    (
        'GV01', -- MaGV - varchar(5)
        N'Bill Gate' -- TenGv - nvarchar(50)
    ),
    (
        'GV02', -- MaGV - varchar(5)
        N'Warren Buffett' -- TenGv - nvarchar(50)
    ),
    (
        'GV03', -- MaGV - varchar(5)
        N'Donald Trump' -- TenGv - nvarchar(50)
    ),
    (
        'GV04', -- MaGV - varchar(5)
        N'Ngọc Trinh' -- TenGv - nvarchar(50)
    ),
    (
        'GV5', -- MaGV - varchar(5)
        N'Đàm Vĩnh Hưng' -- TenGv - nvarchar(50)
    ),
    (
        'GV06', -- MaGV - varchar(5)
        N'Trấn Thành' -- TenGv - nvarchar(50)
    ),
    (
        'GV07', -- MaGV - varchar(5)
        N'Trường Giang' -- TenGv - nvarchar(50)
    ),
    (
        'GV08', -- MaGV - varchar(5)
        N'Mai Phương Thúy' -- TenGv - nvarchar(50)
    )
GO 

INSERT dbo.tbHocVien
    (
        MaHV,
        HoTen,
        DiaChi
    )
VALUES
    (
        'HV01',  -- MaHV - varchar(5)
        N'Hoàng Minh Tâm', -- HoTen - nvarchar(50)
        N'TPHCM'  -- DiaChi - nvarchar(60)
    ),
    (
        'HV02',  -- MaHV - varchar(5)
        N'Ngô Thị Đoan Dung', -- HoTen - nvarchar(50)
        N'Bình Dương'  -- DiaChi - nvarchar(60)
    ),
    (
        'HV03',  -- MaHV - varchar(5)
        N'Nguyễn Ngọc Huyền', -- HoTen - nvarchar(50)
        N'Củ Chi'  -- DiaChi - nvarchar(60)
    ),
    (
        'HV04',  -- MaHV - varchar(5)
        N'Nguyễn Quốc Bảo', -- HoTen - nvarchar(50)
        N'TPHCM'  -- DiaChi - nvarchar(60)
    ),
    (
        'HV05',  -- MaHV - varchar(5)
        N'Đàm Hoàng Anh', -- HoTen - nvarchar(50)
        N'Hà Tĩnh'  -- DiaChi - nvarchar(60)
    ),
    (
        'HV06',  -- MaHV - varchar(5)
        N'Lương Trúc Quỳnh', -- HoTen - nvarchar(50)
        N'Tây Ninh'  -- DiaChi - nvarchar(60)
    ),
    (
        'HV07',  -- MaHV - varchar(5)
        N'Nguyễn Anh Đức', -- HoTen - nvarchar(50)
        N'Đà Lạt'  -- DiaChi - nvarchar(60)
    ),
    (
        'HV08',  -- MaHV - varchar(5)
        N'Lôi Bửu Bửu', -- HoTen - nvarchar(50)
        N'Hà Nội'  -- DiaChi - nvarchar(60)
    ),
    (
        'HV09',  -- MaHV - varchar(5)
        N'Nguyễn Ngọc Thiên Kim', -- HoTen - nvarchar(50)
        N'Hải Dương'  -- DiaChi - nvarchar(60)
    ),
    (
        'HV10',  -- MaHV - varchar(5)
        N'Võ Minh Thư', -- HoTen - nvarchar(50)
        N'TPHCM'  -- DiaChi - nvarchar(60)
    )
GO 

INSERT dbo.tbLopHoc
    (
        MaLop,
        TenLop,
        SiSo,
        MaGV
    )
VALUES 
    (
        'LH01', -- MaLop - varchar(5)
        N'Lớp tiếng Anh', -- TenLop - varchar(30)
        15,  -- SiSo - int
        'GV01'  -- MaGV - varchar(5)
    ),
    (
        'LH02', -- MaLop - varchar(5)
        N'Lớp tiếng Nhật', -- TenLop - varchar(30)
        12,  -- SiSo - int
        'GV03'  -- MaGV - varchar(5)
    ),
    (
        'LH03', -- MaLop - varchar(5)
        N'Lớp tiếng Pháp', -- TenLop - varchar(30)
        11,  -- SiSo - int
        'GV04'  -- MaGV - varchar(5)
    ),
    (
        'LH04', -- MaLop - varchar(5)
        N'Lớp tiếng Trung', -- TenLop - varchar(30)
        19,  -- SiSo - int
        'GV07'  -- MaGV - varchar(5)
    ),
    (
        'LH05', -- MaLop - varchar(5)
        N'Lớp tiếng Việt', -- TenLop - varchar(30)
        10,  -- SiSo - int
        'GV02'  -- MaGV - varchar(5)
    ),
    (
        'LH06', -- MaLop - varchar(5)
        N'Lớp tiếng Nga', -- TenLop - varchar(30)
        20,  -- SiSo - int
        'GV08'  -- MaGV - varchar(5)
    ),
    (
        'LH07', -- MaLop - varchar(5)
        N'Lớp tiếng Ý', -- TenLop - varchar(30)
        15,  -- SiSo - int
        'GV01'  -- MaGV - varchar(5)
    ),
    (
        'LH08', -- MaLop - varchar(5)
        N'Lớp tiếng Thái', -- TenLop - varchar(30)
        19,  -- SiSo - int
        'GV06'  -- MaGV - varchar(5)
    ), 
    (
        'LH09', -- MaLop - varchar(5)
        N'Lớp SQL Server', -- TenLop - varchar(30)
        20,  -- SiSo - int
        'GV01'  -- MaGV - varchar(5)
    )

GO 

INSERT dbo.tbDangKy
    (
        MaHV,
        MaLop,
        NgayDK,
        GhiChu
    )
VALUES
    (
        'HV01',        -- MaHV - varchar(5)
        'LH01',        -- MaLop - varchar(5)
        '20160506', -- NgayDK - date
        'xxx'         -- GhiChu - varchar(100)
    ),
    (
        'HV01',        -- MaHV - varchar(5)
        'LH03',        -- MaLop - varchar(5)
        '20150807', -- NgayDK - date
        'xxx'         -- GhiChu - varchar(100)
    ),
    (
        'HV01',        -- MaHV - varchar(5)
        'LH04',        -- MaLop - varchar(5)
        '20190909', -- NgayDK - date
        'xxx'         -- GhiChu - varchar(100)
    ),
    (
        'HV01',        -- MaHV - varchar(5)
        'LH08',        -- MaLop - varchar(5)
        '20190808', -- NgayDK - date
        'xxx'         -- GhiChu - varchar(100)
    ),
    (
        'HV02',        -- MaHV - varchar(5)
        'LH03',        -- MaLop - varchar(5)
        GETDATE(), -- NgayDK - date
        'gg'         -- GhiChu - varchar(100)
    ),
    (
        'HV02',        -- MaHV - varchar(5)
        'LH07',        -- MaLop - varchar(5)
        GETDATE(), -- NgayDK - date
        'gg'         -- GhiChu - varchar(100)
    ),
    (
        'HV03',        -- MaHV - varchar(5)
        'LH02',        -- MaLop - varchar(5)
        GETDATE(), -- NgayDK - date
        'yyy'         -- GhiChu - varchar(100)
    ),
    (
        'HV04',        -- MaHV - varchar(5)
        'LH01',        -- MaLop - varchar(5)
        '20191212', -- NgayDK - date
        'ff'         -- GhiChu - varchar(100)
    ),
    (
        'HV04',        -- MaHV - varchar(5)
        'LH05',        -- MaLop - varchar(5)
        GETDATE(), -- NgayDK - date
        'tt'         -- GhiChu - varchar(100)
    ),
    (
        'HV06',        -- MaHV - varchar(5)
        'LH06',        -- MaLop - varchar(5)
        '20001212', -- NgayDK - date
        'xxx'         -- GhiChu - varchar(100)
    ),
    (
        'HV09',        -- MaHV - varchar(5)
        'LH07',        -- MaLop - varchar(5)
        '20141111', -- NgayDK - date
        'xxx'         -- GhiChu - varchar(100)
    ),
    (
        'HV05',        -- MaHV - varchar(5)
        'LH09',        -- MaLop - varchar(5)
        '20141111', -- NgayDK - date
        'xxx'         -- GhiChu - varchar(100)
    ),
    (
        'HV08',        -- MaHV - varchar(5)
        'LH09',        -- MaLop - varchar(5)
        '20190905', -- NgayDK - date
        'gg'         -- GhiChu - varchar(100)
    ),
    (
        'HV07',        -- MaHV - varchar(5)
        'LH09',        -- MaLop - varchar(5)
        '20111212', -- NgayDK - date
        'uu'         -- GhiChu - varchar(100)
    )
GO 

--3. Tạo clustered index idxHV trên cột Hoten của bảng tbHOCVIEN
--	 Tạo index idxGV trên cột TenGV của bảng tbGIAOVIEN theo thứ tự giảm dần

--Tạo clustered index idxHV trên cột Hoten của bảng tbHOCVIEN
CREATE CLUSTERED INDEX idxHV ON dbo.tbHocVien (HoTen)
GO 

--Tạo index idxGV trên cột TenGV của bảng tbGIAOVIEN theo thứ tự giảm dần
CREATE CLUSTERED INDEX idxGV ON dbo.tbGiaoVien(TenGv desc)
GO 

--4. Tìm các học viên có Hoten bắt đầu là ‘L’ và đăng ký học lớp ‘SQL Server’ ( giả sử trong phần nhập liệu có lớp này )

SELECT a.MaHV,a.HoTen,a.DiaChi,b.NgayDK,c.MaLop,c.TenLop
FROM dbo.tbHocVien a JOIN (dbo.tbDangKy b JOIN dbo.tbLopHoc c ON c.MaLop = b.MaLop) ON b.MaHV = a.MaHV
WHERE a.HoTen LIKE 'L%' and c.TenLop LIKE '%SQL%'
GO 

-- 5. Tìm các học viên đăng ký từ 2 lớp học trở lên
SELECT a.MaHV,a.HoTen,COUNT(*) AS N'Số Lớp Đăng Ký'
FROM dbo.tbHocVien a JOIN dbo.tbDangKy b ON b.MaHV = a.MaHV
GROUP BY a.MaHV,a.HoTen
HAVING COUNT(*)>=2
GO 

-- 6. Tạo view vwLopHoc Hiển thị Malop , Tenlop , TenGV và số lượng học viên đã đăng ký
SELECT * FROM dbo.tbLopHoc
SELECT * FROM dbo.tbGiaoVien
GO 

CREATE VIEW vwLopHoc
AS 
SELECT a.MaLop,a.TenLop,b.TenGv,a.SiSo
FROM dbo.tbLopHoc a JOIN dbo.tbGiaoVien b ON b.MaGV = a.MaGV
GO 

SELECT * FROM dbo.vwLopHoc
GO 

--7. Tạo 1 Stored procedure uspGV nhận tham số là họ tên của giáo viên và liệt kê thông tin về các lớp học mà giáo viên này đang giảng dạy
CREATE PROC uspGV
@HoTenGV NVARCHAR(50)
AS 
BEGIN
	SELECT b.TenGv,a.MaLop,a.TenLop,a.SiSo
	FROM dbo.tbLopHoc a JOIN dbo.tbGiaoVien b ON b.MaGV = a.MaGV
	WHERE b.TenGv=@HoTenGV ;
END 
GO 

EXEC dbo.uspGV
    @HoTenGV = N'Bill Gate' -- nvarchar(50)
GO 

-- 8. Tạo (insert, update) Trigger trDangky bảo đảm 1 học viên chỉ được đăng ký tối đa 2 lớp

-- Tạo Trigger Insert  ????????
CREATE TRIGGER trDangKy
ON dbo.tbDangKy
FOR INSERT AS 
BEGIN
	DECLARE @solop=
END 
GO 


-- 9. Tạo (update) Trigger trHVTen không cho phép đổi tên học viên
CREATE TRIGGER trHVTen
ON dbo.tbHocVien
AFTER UPDATE AS
BEGIN 
	IF UPDATE(HoTen)
	BEGIN 
		PRINT N'Không thể đổi tên học viên'
		ROLLBACK
	END 
END
GO 

UPDATE dbo.tbHocVien SET HoTen=N'Seohyun' WHERE MaHV='HV02'
GO 

--10. Tạo (instead of delete) Trigger trLop khi xóa 1 lớp học thì sẽ xóa luôn các dữ liệu đăng ký lớp học đó trong bảng đăng ký.
CREATE TRIGGER trLop
ON dbo.tbLopHoc
INSTEAD OF DELETE AS 
BEGIN	
	DELETE FROM dbo.tbDangKy WHERE MaLop IN 
	(SELECT MaLop FROM Deleted)
	DELETE FROM dbo.tbLopHoc WHERE MaLop IN 
	(SELECT MaLop FROM Deleted)
END 
GO 

--Tạo dữ liệu để test trigger
INSERT dbo.tbLopHoc
    (
        MaLop,
        TenLop,
        SiSo,
        MaGV
    )
VALUES
    (
        'LH10', -- MaLop - varchar(5)
        N'Lớp Tạo Cho Vui', -- TenLop - varchar(30)
        20,  -- SiSo - int
        'GV01'  -- MaGV - varchar(5)
    ),
    (
        'LH11', -- MaLop - varchar(5)
        N'Lớp Tạo Chút Xóa', -- TenLop - varchar(30)
        10,  -- SiSo - int
        'GV02'  -- MaGV - varchar(5)
    )
GO 

INSERT dbo.tbDangKy
    (
        MaHV,
        MaLop,
        NgayDK,
        GhiChu
    )
VALUES
    (
        'HV09',        -- MaHV - varchar(5)
        'LH10',        -- MaLop - varchar(5)
        GETDATE(), -- NgayDK - date
        '123'         -- GhiChu - varchar(100)
    ),	
    (
        'HV07',        -- MaHV - varchar(5)
        'LH10',        -- MaLop - varchar(5)
        GETDATE(), -- NgayDK - date
        'dfd3'         -- GhiChu - varchar(100)
    ),
    (
        'HV07',        -- MaHV - varchar(5)
        'LH11',        -- MaLop - varchar(5)
        GETDATE(), -- NgayDK - date
        '13253'         -- GhiChu - varchar(100)
    ),
    (
        'HV02',        -- MaHV - varchar(5)
        'LH11',        -- MaLop - varchar(5)
        GETDATE(), -- NgayDK - date
        '545'         -- GhiChu - varchar(100)
    )
GO 

SELECT * FROM dbo.tbLopHoc
SELECT * FROM dbo.tbDangKy

--Xóa thử 2 Lớp vừa tạo mã LH10 và Lh11
DELETE FROM dbo.tbLopHoc WHERE MaLop = 'LH11'
GO 

DELETE FROM dbo.tbLopHoc WHERE MaLop = 'LH10'
GO 
