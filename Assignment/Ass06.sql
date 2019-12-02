CREATE DATABASE Ass6_db
ON	
( NAME='Ass6',FILENAME='D:\Study\Aptech\Season1\SQL\Database\Ass6.mdf',
  SIZE=5,FILEGROWTH=10%,MAXSIZE=5
)
LOG ON	
( NAME='Ass6_lg',FILENAME='D:\Study\Aptech\Season1\SQL\Database\Ass6_lg.ldf',
  SIZE=2,FILEGROWTH=10%,MAXSIZE=2
)
GO

USE Ass6_db
GO	

CREATE TABLE tbMonHoc
(
	MSMH VARCHAR(10) NOT NULL PRIMARY KEY,
	TENMH VARCHAR(50) NOT NULL,
	SOTINCHI TINYINT DEFAULT 3,
	[Tinh Chat] TINYINT CHECK([Tinh Chat] = 0 OR [Tinh Chat]=1)
)
GO

CREATE TABLE tbLop
(
	MALOP VARCHAR(5) NOT NULL PRIMARY KEY,
	[TEN LOP] VARCHAR(20) NOT NULL,
	[SI SO] SMALLINT 
)
GO	

CREATE TABLE tbSinhVien
(
	MSSV VARCHAR(20) NOT NULL PRIMARY KEY,
	HOTEN NVARCHAR(30) NOT NULL,
	NGAYSINH DATE,
	MALOP VARCHAR(5) NOT NULL FOREIGN KEY REFERENCES dbo.tbLop(MALOP)
)
GO 

CREATE TABLE tbDiem
(
	MSSV VARCHAR(20) NOT NULL FOREIGN KEY REFERENCES dbo.tbSinhVien(MSSV),
	MSMH VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES dbo.tbMonHoc(MSMH),
	[DIEM THI] SMALLINT NOT NULL
)
GO 

--Cau b
ALTER TABLE dbo.tbSinhVien
	ADD [GIOI TINH] VARCHAR(1) CHECK([GIOI TINH] = 'F' OR [GIOI TINH] = 'M')
GO 

INSERT dbo.tbMonHoc
    (
        MSMH,
        TENMH,
        SOTINCHI,
        [Tinh Chat]
    )
VALUES
    (
        'LPEP', -- MSMH - varchar(10)
        'Logic Building With C', -- TENMH - varchar(50)
        6,  -- SOTINCHI - tinyint
        1   -- Tinh Chat - tinyint
    ),	 
    (
        'BNGW', -- MSMH - varchar(10)
        'Building Next Generation Websites', -- TENMH - varchar(50)
        5,  -- SOTINCHI - tinyint
        1   -- Tinh Chat - tinyint
    ),	 	 
    (
        'BSJ', -- MSMH - varchar(10)
        'BootStrap and jQuery', -- TENMH - varchar(50)
        2,  -- SOTINCHI - tinyint
        0   -- Tinh Chat - tinyint
    ), 	   	 	 
    (
        'eP1', -- MSMH - varchar(10)
        'eProject1', -- TENMH - varchar(50)
        3,  -- SOTINCHI - tinyint
        1   -- Tinh Chat - tinyint
    ), 	 	 
    (
        'DDD', -- MSMH - varchar(10)
        'Database Design and Development', -- TENMH - varchar(50)
        3,  -- SOTINCHI - tinyint
        0   -- Tinh Chat - tinyint
    ), 	 	 
    (
        'DM', -- MSMH - varchar(10)
        'Database Management (SQL Server)', -- TENMH - varchar(50)
        7,  -- SOTINCHI - tinyint
        1   -- Tinh Chat - tinyint
    )
GO  

INSERT dbo.tbLop
    (
        MALOP,
        [TEN LOP],
        [SI SO]
    )
VALUES
    (
        '1907', -- MALOP - varchar(5)
        'Lop 1907', -- TEN LOP - varchar(20)
        20   -- SI SO - smallint
    ),
	
    (
        '1908', -- MALOP - varchar(5)
        'Lop 1908', -- TEN LOP - varchar(20)
        25   -- SI SO - smallint
    ),	 
    (
        '1909', -- MALOP - varchar(5)
        'Lop 1909', -- TEN LOP - varchar(20)
        15   -- SI SO - smallint
    ),	
    (
        '1910', -- MALOP - varchar(5)
        'Lop 1910', -- TEN LOP - varchar(20)
        22   -- SI SO - smallint
    ),	 
    (
        '1911', -- MALOP - varchar(5)
        'Lop 1911', -- TEN LOP - varchar(20)
        23   -- SI SO - smallint
    )
GO

INSERT dbo.tbSinhVien
    (
        MSSV,
        HOTEN,
        NGAYSINH,
        MALOP,
		[GIOI TINH]
    )
VALUES
    (
        'SV01',        -- MSSV - varchar(20)
        N'Hoàng Minh Tâm',       -- HOTEN - nvarchar(30)
        '19920309', -- NGAYSINH - date
        '1907'  ,       -- MALOP - varchar(5)
		'M'
    ),		
    (
        'SV02',        -- MSSV - varchar(20)
        N'Ngô Thị Đoan Dung',       -- HOTEN - nvarchar(30)
        '20001212', -- NGAYSINH - date
        '1907'   ,      -- MALOP - varchar(5)
		'F'
    ),	  
    (
        'SV03',        -- MSSV - varchar(20)
        N'Nguyễn Thiên Kim',       -- HOTEN - nvarchar(30)
        '20010506', -- NGAYSINH - date
        '1908'   ,      -- MALOP - varchar(5)
		'F'
    ),	
    (
        'SV04',        -- MSSV - varchar(20)
        N'Đàm Hoàng Anh',       -- HOTEN - nvarchar(30)
        '19890908', -- NGAYSINH - date
        '1909'   ,      -- MALOP - varchar(5)
		'M'
    ),	  
    (
        'SV05',        -- MSSV - varchar(20)
        N'Võ Hoàng Trung',       -- HOTEN - nvarchar(30)
        '19980909', -- NGAYSINH - date
        '1909'    ,     -- MALOP - varchar(5)
		'M'
    ),	 
    (
        'SV06',        -- MSSV - varchar(20)
        N'Nguyễn Quốc Bảo',       -- HOTEN - nvarchar(30)
        '20050505', -- NGAYSINH - date
        '1910'    ,     -- MALOP - varchar(5)   
		'M'
    ),	
    (
        'SV07',        -- MSSV - varchar(20)
        N'Trần Hòa',       -- HOTEN - nvarchar(30)
        '20040505', -- NGAYSINH - date
        '1910'  ,       -- MALOP - varchar(5)
		'M'
    ),	  
    (
        'SV08',        -- MSSV - varchar(20)
        N'Võ Minh Thư',       -- HOTEN - nvarchar(30)
        '20060606', -- NGAYSINH - date
        '1911'    ,     -- MALOP - varchar(5)
		'F'
    )
GO 

SELECT* FROM dbo.tbMonHoc
SELECT* FROM dbo.tbSinhVien
SELECT * FROM dbo.tbDiem
GO 

INSERT dbo.tbDiem
    (
        MSSV,
        MSMH,
        [DIEM THI]
    )
VALUES
    (
        'SV01', -- MSSV - varchar(20)
        'LPEP', -- MSMH - varchar(10)
        100   -- DIEM THI - smallint
    ),
    (
        'SV01', -- MSSV - varchar(20)
        'BNGW', -- MSMH - varchar(10)
        100   -- DIEM THI - smallint
    ),
	(
        'SV01', -- MSSV - varchar(20)
        'BSJ', -- MSMH - varchar(10)
        100   -- DIEM THI - smallint
    ),
	(
        'SV01', -- MSSV - varchar(20)
        'eP1', -- MSMH - varchar(10)
        100   -- DIEM THI - smallint
    ),	  
	(
        'SV01', -- MSSV - varchar(20)
        'DDD', -- MSMH - varchar(10)
        100   -- DIEM THI - smallint
    ),   
	(
        'SV01', -- MSSV - varchar(20)
        'DM', -- MSMH - varchar(10)
        100   -- DIEM THI - smallint
    ), 
	(
        'SV02', -- MSSV - varchar(20)
        'LPEP', -- MSMH - varchar(10)
        90   -- DIEM THI - smallint
    ),   
    (
        'SV02', -- MSSV - varchar(20)
        'BNGW', -- MSMH - varchar(10)
        100   -- DIEM THI - smallint
    ),
	(
        'SV02', -- MSSV - varchar(20)
        'BSJ', -- MSMH - varchar(10)
        95   -- DIEM THI - smallint
    ),
	(
        'SV02', -- MSSV - varchar(20)
        'eP1', -- MSMH - varchar(10)
        90   -- DIEM THI - smallint
    ),	  
	(
        'SV02', -- MSSV - varchar(20)
        'DDD', -- MSMH - varchar(10)
        100   -- DIEM THI - smallint
    ),   
	(
        'SV02', -- MSSV - varchar(20)
        'DM', -- MSMH - varchar(10)
        80   -- DIEM THI - smallint
    ),    
	(
        'SV03', -- MSSV - varchar(20)
        'LPEP', -- MSMH - varchar(10)
        50   -- DIEM THI - smallint
    ),   
    (
        'SV03', -- MSSV - varchar(20)
        'BNGW', -- MSMH - varchar(10)
        90   -- DIEM THI - smallint
    ),
	(
        'SV03', -- MSSV - varchar(20)
        'eP1', -- MSMH - varchar(10)
        70   -- DIEM THI - smallint
    ),	  
	(
        'SV03', -- MSSV - varchar(20)
        'DDD', -- MSMH - varchar(10)
        60   -- DIEM THI - smallint
    ),   
	(
        'SV03', -- MSSV - varchar(20)
        'DM', -- MSMH - varchar(10)
        80   -- DIEM THI - smallint
    ),  
    (
        'SV04', -- MSSV - varchar(20)
        'BNGW', -- MSMH - varchar(10)
        80   -- DIEM THI - smallint
    ),
	(
        'SV04', -- MSSV - varchar(20)
        'BSJ', -- MSMH - varchar(10)
        65   -- DIEM THI - smallint
    ),
	(
        'SV04', -- MSSV - varchar(20)
        'eP1', -- MSMH - varchar(10)
        50   -- DIEM THI - smallint
    ),	  
	(
        'SV04', -- MSSV - varchar(20)
        'DDD', -- MSMH - varchar(10)
        50   -- DIEM THI - smallint
    ),	   
	(
        'SV05', -- MSSV - varchar(20)
        'LPEP', -- MSMH - varchar(10)
        40   -- DIEM THI - smallint
    ),   
    (
        'SV05', -- MSSV - varchar(20)
        'BNGW', -- MSMH - varchar(10)
        90   -- DIEM THI - smallint
    ),
	(
        'SV05', -- MSSV - varchar(20)
        'eP1', -- MSMH - varchar(10)
        70   -- DIEM THI - smallint
    ),	  
	(
        'SV05', -- MSSV - varchar(20)
        'DDD', -- MSMH - varchar(10)
        30   -- DIEM THI - smallint
    ),   
	(
        'SV05', -- MSSV - varchar(20)
        'DM', -- MSMH - varchar(10)
        20   -- DIEM THI - smallint
    ),  
	(
        'SV06', -- MSSV - varchar(20)
        'LPEP', -- MSMH - varchar(10)
        35   -- DIEM THI - smallint
    ),   
    (
        'SV06', -- MSSV - varchar(20)
        'BNGW', -- MSMH - varchar(10)
        20   -- DIEM THI - smallint
    ),
	(
        'SV06', -- MSSV - varchar(20)
        'BSJ', -- MSMH - varchar(10)
        85   -- DIEM THI - smallint
    ),
	(
        'SV06', -- MSSV - varchar(20)
        'eP1', -- MSMH - varchar(10)
        90   -- DIEM THI - smallint
    ),	
	(
        'SV06', -- MSSV - varchar(20)
        'DM', -- MSMH - varchar(10)
        50   -- DIEM THI - smallint
    ),
	(
        'SV07', -- MSSV - varchar(20)
        'LPEP', -- MSMH - varchar(10)
        90   -- DIEM THI - smallint
    ),   
    (
        'SV07', -- MSSV - varchar(20)
        'BNGW', -- MSMH - varchar(10)
        55   -- DIEM THI - smallint
    ),
	(
        'SV07', -- MSSV - varchar(20)
        'BSJ', -- MSMH - varchar(10)
        65   -- DIEM THI - smallint
    ),
	(
        'SV07', -- MSSV - varchar(20)
        'eP1', -- MSMH - varchar(10)
        50   -- DIEM THI - smallint
    ),	  
	(
        'SV07', -- MSSV - varchar(20)
        'DDD', -- MSMH - varchar(10)
        50   -- DIEM THI - smallint
    ),   
	(
        'SV07', -- MSSV - varchar(20)
        'DM', -- MSMH - varchar(10)
        90   -- DIEM THI - smallint
    ), 
	(
        'SV08', -- MSSV - varchar(20)
        'LPEP', -- MSMH - varchar(10)
        60   -- DIEM THI - smallint
    ),   
    (
        'SV08', -- MSSV - varchar(20)
        'BNGW', -- MSMH - varchar(10)
        65   -- DIEM THI - smallint
    ),
	(
        'SV08', -- MSSV - varchar(20)
        'BSJ', -- MSMH - varchar(10)
        85   -- DIEM THI - smallint
    ),
	(
        'SV08', -- MSSV - varchar(20)
        'eP1', -- MSMH - varchar(10)
        50   -- DIEM THI - smallint
    ),	  
	(
        'SV08', -- MSSV - varchar(20)
        'DDD', -- MSMH - varchar(10)
        90   -- DIEM THI - smallint
    ),   
	(
        'SV08', -- MSSV - varchar(20)
        'DM', -- MSMH - varchar(10)
        65   -- DIEM THI - smallint
    )     

GO 



--Câu c
SELECT *
FROM dbo.tbMonHoc
WHERE [Tinh Chat]=1
ORDER BY SOTINCHI DESC
GO 

--Câu d
SELECT a.MSSV,a.HOTEN,a.MALOP,b.[DIEM THI],c.TENMH
FROM dbo.tbSinhVien a JOIN (dbo.tbDiem b JOIN dbo.tbMonHoc c ON c.MSMH = b.MSMH) ON b.MSSV = a.MSSV 
WHERE c.TENMH LIKE '%SQL%'
GO 

--Câu e
SELECT *
FROM dbo.tbDiem
WHERE MSMH='DM'
ORDER BY [DIEM THI] DESC 
GO 

--Câu f
SELECT a.MSSV,a.HOTEN,a.NGAYSINH,a.[GIOI TINH],b.[TEN LOP],d.MSMH,d.TENMH,c.[DIEM THI] 
FROM (dbo.tbSinhVien a JOIN dbo.tbLop b ON	b.MALOP = a.MALOP) LEFT JOIN (dbo.tbDiem c JOIN dbo.tbMonHoc d ON d.MSMH = c.MSMH) ON c.MSSV = a.MSSV
WHERE a.MSSV='SV02'
GO 

--Câu g
SELECT MSSV,AVG([DIEM THI]) AS N'Điểm Trung Bình'
FROM dbo.tbDiem
GROUP BY MSSV
HAVING AVG([DIEM THI])<75
ORDER BY AVG([DIEM THI])
GO  


--Câu g		  
SELECT b.MSSV,b.HOTEN,b.MALOP,AVG(a.[DIEM THI]) AS N'Điểm Trung Bình'
FROM dbo.tbDiem	a RIGHT JOIN dbo.tbSinhVien b ON b.MSSV = a.MSSV
GROUP BY b.MSSV,b.HOTEN,b.MALOP
HAVING AVG(a.[DIEM THI])<75
ORDER BY AVG(a.[DIEM THI])
GO  

--Câu h	   (chưa biết cách có lớp và HOTEN)
CREATE VIEW vwDiemTrungBinh
AS 
SELECT b.MSSV,c.[TEN LOP],b.HOTEN,AVG([DIEM THI]) AS N'Điểm Trung Bình'
FROM dbo.tbDiem	a JOIN (dbo.tbSinhVien b JOIN dbo.tbLop c ON c.MALOP = b.MALOP) ON c.MALOP = b.MALOP
GROUP BY b.MSSV,c.[TEN LOP],b.HOTEN
GO 

SELECT *
FROM dbo.vwDiemTrungBinh
GO 

--Câu i
SELECT * 
FROM dbo.tbDiem
ORDER BY MSMH
GO 

