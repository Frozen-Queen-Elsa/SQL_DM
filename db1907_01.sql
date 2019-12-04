--Tạo cơ sở dữ liệu lớp 1907
CREATE DATABASE db_1907
GO

 USE db_1907
 GO
 
--Tạo bảng sinh viên
CREATE TABLE tbStudent
(
	st_id VARCHAR(5) NOT NULL PRIMARY KEY,
	st_name NVARCHAR(40) NOT NULL, 
	st_gender BIT NOT NULL DEFAULT 1,
	st_dob DATE,
	st_add NVARCHAR(100)
)
GO	

ALTER TABLE dbo.tbStudent
		ALTER COLUMN st_name NVARCHAR(60) NOT NULL
GO	

ALTER TABLE dbo.tbStudent
		ADD	st_iq TINYINT
GO	

CREATE TABLE tbExample
(
	person_id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	person_name NVARCHAR(60) NOT NULL
);
GO	

INSERT dbo.tbExample
	(person_name)
VALUES
    (N'Kim Dung'  ), -- person_name - nvarchar(60)   
    (N'Bảo Bảo'   ),-- person_name - nvarchar(60)	   
    (N'Ngọc Huyền' ),  -- person_name - nvarchar(60) 
    (N'Hoàng Anh' ),  -- person_name - nvarchar(60)  
    (N'Minh Tâm'  ) -- person_name - nvarchar(60)   
GO	

SELECT * FROM dbo.tbExample
GO	

--Tạo bảng môn học
CREATE TABLE tbSubject
(
	sub_id TINYINT IDENTITY(100,5) PRIMARY KEY,
	sub_name VARCHAR(30) UNIQUE NOT NULL,
	sub_fee SMALLINT NOT NULL DEFAULT 100 ,
	sub_hours TINYINT NOT NULL
)
GO	

--Tạo bảng Kiểm tra
CREATE TABLE tbExam
(
	exam_id INT IDENTITY(1000,1) PRIMARY KEY,
	st_id VARCHAR(5) NOT NULL,
	sub_id TINYINT NOT NULL,
	mark TINYINT,
	FOREIGN KEY (st_id) REFERENCES dbo.tbStudent,
	FOREIGN KEY (sub_id) REFERENCES dbo.tbSubject	
)
GO	


-- Thêm 1 ràng buộc kiểm tra điểm phải trong giới hạn 0>100
ALTER TABLE dbo.tbExam
	ADD CONSTRAINT ckMark CHECK (mark >=0 AND mark <=100);
GO	


ALTER TABLE dbo.tbStudent
	ADD	CONSTRAINT ckIQ CHECK	(st_iq BETWEEN 80 AND 160);
GO 


-- Tạo dữ liệu cho bảng Student
SELECT * FROM dbo.tbStudent
GO	

INSERT dbo.tbStudent
(
    st_id,
    st_name,
    st_gender,
    st_dob,
    st_add,
    st_iq
)
VALUES
(   'ST01',        -- st_id - varchar(5)
    N'Hoàng Minh Tâm',       -- st_name - nvarchar(60)
    1,      -- st_gender - bit
    '19920309', -- st_dob - date
    N'CMT8',        -- st_add - varchar(50)
    150          -- st_iq - tinyint
),
(   'ST02',        -- st_id - varchar(5)
    N'Ngô Thị Đoan Dung',       -- st_name - nvarchar(60)
    0,      -- st_gender - bit
    '20011231', -- st_dob - date
    N'CMT8',        -- st_add - varchar(50)
    140          -- st_iq - tinyint
),
(   'ST03',        -- st_id - varchar(5)
    N'Nguyễn Ngọc Huyền',       -- st_name - nvarchar(60)
    0,      -- st_gender - bit
    '20060401', -- st_dob - date
    N'Nam Kỳ Khởi Nghĩa',        -- st_add - varchar(50)
    120          -- st_iq - tinyint
)
GO	


INSERT dbo.tbStudent
(
    st_id,
    st_name,
    st_gender,
    st_dob,
    st_add,
    st_iq
)
VALUES
(   'ST04',        -- st_id - varchar(5)
    N'Bùi Đình Hùng',       -- st_name - nvarchar(60)
    1,      -- st_gender - bit
    '20011002', -- st_dob - date
    N'Tân Phú',        -- st_add - varchar(50)
    120          -- st_iq - tinyint
),
(   'ST05',        -- st_id - varchar(5)
    N'Nguyễn Đình Huy',       -- st_name - nvarchar(60)
    1,      -- st_gender - bit
    '20010520', -- st_dob - date
    N'DakLak',        -- st_add - varchar(50)
    80          -- st_iq - tinyint
),
(   'ST06',        -- st_id - varchar(5)
    N'Lôi Bửu Bửu',       -- st_name - nvarchar(60)
    0,      -- st_gender - bit
    '20080524', -- st_dob - date
    N'LonDon',        -- st_add - varchar(50)
    145          -- st_iq - tinyint
),
(   'ST07',        -- st_id - varchar(5)
    N'Nguyễn Ngọc Thiên Kim',       -- st_name - nvarchar(60)
    0,      -- st_gender - bit
    '20021010', -- st_dob - date
    N'Đồng Nai',        -- st_add - varchar(50)
    81         -- st_iq - tinyint
),
(   'ST08',        -- st_id - varchar(5)
    N'Phạm Trọng Nghĩa',       -- st_name - nvarchar(60)
    1,      -- st_gender - bit
    '20001231', -- st_dob - date
    N'Nam Định',        -- st_add - varchar(50)
    100          -- st_iq - tinyint
),
(   'ST09',        -- st_id - varchar(5)
    N'Lương Trúc Quỳnh',       -- st_name - nvarchar(60)
    0,      -- st_gender - bit
    '20010725', -- st_dob - date
    N'Tây Ninh',        -- st_add - varchar(50)
    99          -- st_iq - tinyint
),
(   'ST10',        -- st_id - varchar(5)
    N'Võ Hoàng Trung',       -- st_name - nvarchar(60)
    1,      -- st_gender - bit
    '20010607', -- st_dob - date
    N'Hà Nội',        -- st_add - varchar(50)
    80          -- st_iq - tinyint
),
(   'ST11',        -- st_id - varchar(5)
    N'Lê Bá Hưng',       -- st_name - nvarchar(60)
    1,      -- st_gender - bit
    '20011109', -- st_dob - date
    N'Bình Thuận',        -- st_add - varchar(50)
    120          -- st_iq - tinyint
),
(   'ST12',        -- st_id - varchar(5)
    N'Lê Thanh Ân',       -- st_name - nvarchar(60)
    1,      -- st_gender - bit
    '20070101', -- st_dob - date
    N'Quảng Trị',        -- st_add - varchar(50)
    120          -- st_iq - tinyint
),
(   'ST13',        -- st_id - varchar(5)
    N'Phạm Anh Đức',       -- st_name - nvarchar(60)
    1,      -- st_gender - bit
    '20080425', -- st_dob - date
    N'Quảng Bình',        -- st_add - varchar(50)
    130         -- st_iq - tinyint
),
(   'ST14',        -- st_id - varchar(5)
    N'Nguyễn Văn Bình',       -- st_name - nvarchar(60)
    1,      -- st_gender - bit
    '20080520', -- st_dob - date
    N'Bình Dương',        -- st_add - varchar(50)
    120          -- st_iq - tinyint
),
(   'ST15',        -- st_id - varchar(5)
    N'Đàm Hoàng Anh',       -- st_name - nvarchar(60)
    1,      -- st_gender - bit
    '20090520', -- st_dob - date
    N'Hà Tĩnh',        -- st_add - varchar(50)
    140          -- st_iq - tinyint
),
(   'ST16',        -- st_id - varchar(5)
    N'Lê Minh Tiến Đoàn',       -- st_name - nvarchar(60)
    1,      -- st_gender - bit
    '19970520', -- st_dob - date
    N'Đà Lạt',        -- st_add - varchar(50)
    143          -- st_iq - tinyint
)
GO	


--Nhập dữ liệu cho bảng Môn Học
SELECT * FROM dbo.tbSubject
GO	

INSERT dbo.tbSubject
    (
        sub_name,
        sub_fee,
        sub_hours
    )
VALUES
    (
        'Logic Building With C', -- sub_name - varchar(30)
        150,  -- sub_fee - smallint
        40   -- sub_hours - tinyint
    ), 
    (
        'HTML/CSS3 - JS', -- sub_name - varchar(30)
        180,  -- sub_fee - smallint
        44   -- sub_hours - tinyint
    ),	  
    (
        'Bootstrap - Jquery', -- sub_name - varchar(30)
        80,  -- sub_fee - smallint
       10   -- sub_hours - tinyint
    ),	
    (
        'eProject I', -- sub_name - varchar(30)
        100,  -- sub_fee - smallint
        24   -- sub_hours - tinyint
    ),	
    (
        'Database Design ', -- sub_name - varchar(30)
        100,  -- sub_fee - smallint
        20   -- sub_hours - tinyint
    ),	 
    (
        'Database Development', -- sub_name - varchar(30)
        200,  -- sub_fee - smallint
        48   -- sub_hours - tinyint
    )
GO


--Sửa lại thông tin môn lập trình C tăng học phí từ 150 > 160
UPDATE dbo.tbSubject 
	SET	sub_fee =160 WHERE sub_id=100
GO	


--Cập nhật dữ liệu điểm môn C cho các sinh viên	(ST01-ST16)
SELECT * FROM dbo.tbExam
GO 

INSERT dbo.tbExam
    (
        st_id,
        sub_id,
        mark
    )
VALUES
    (
        'ST01', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        100   -- mark - tinyint
    ), 
    (
        'ST02', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        30   -- mark - tinyint
    ),	  
    (
        'ST03', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        50   -- mark - tinyint
    ),
	
    (
        'ST04', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        60   -- mark - tinyint
    ), 
    (
        'ST05', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        40  -- mark - tinyint
    ),		   	
    (
        'ST06', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        60   -- mark - tinyint
    ),		
    (
        'ST07', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        80   -- mark - tinyint
    ),				  
	(
        'ST08', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        80   -- mark - tinyint
    ),	
    (
        'ST09', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        30   -- mark - tinyint
    ),	  
    (
        'ST10', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        70   -- mark - tinyint
    ),	  					 
    (
        'ST11', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        90   -- mark - tinyint
    ),	  
    (
        'ST12', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        70   -- mark - tinyint
    ),	  
    (
        'ST13', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        40   -- mark - tinyint
    ),	  
    (
        'ST14', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        10   -- mark - tinyint
    ),	  
    (
        'ST15', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        75   -- mark - tinyint
    ),	  
    (
        'ST16', -- st_id - varchar(5)
        100,  -- sub_id - tinyint
        70   -- mark - tinyint
    )		 
	
GO	


--Cập nhật dữ liệu điểm môn HTML cho các sinh viên	(ST01-ST16)
SELECT * FROM dbo.tbExam
GO 
   
INSERT dbo.tbExam
    (
        st_id,
        sub_id,
        mark
    )
VALUES
    (
        'ST01', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        100   -- mark - tinyint
    ), 
    (
        'ST02', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        90   -- mark - tinyint
    ),	  
    (
        'ST03', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        80   -- mark - tinyint
    ),
	
    (
        'ST04', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        90   -- mark - tinyint
    ), 
    (
        'ST05', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        80  -- mark - tinyint
    ),		   	
    (
        'ST06', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        90   -- mark - tinyint
    ),		
    (
        'ST07', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        30   -- mark - tinyint
    ),			
    (
        'ST08', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        30   -- mark - tinyint
    ),	
    (
        'ST09', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        20   -- mark - tinyint
    ),	  
    (
        'ST10', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        70   -- mark - tinyint
    ),	  					 
    (
        'ST11', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        95   -- mark - tinyint
    ),	  
    (
        'ST12', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        75   -- mark - tinyint
    ),	  
    (
        'ST13', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        70   -- mark - tinyint
    ),	  
    (
        'ST14', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        80   -- mark - tinyint
    ),	  
    (
        'ST15', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        60   -- mark - tinyint
    ),	  
    (
        'ST16', -- st_id - varchar(5)
        105,  -- sub_id - tinyint
        20   -- mark - tinyint
    )
GO	


--Cập nhật dữ liệu điểm môn Bootstrap cho các sinh viên	(ST01-ST16)
SELECT * FROM dbo.tbExam
GO 
   
INSERT dbo.tbExam
    (
        st_id,
        sub_id,
        mark
    )
VALUES
    (
        'ST01', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        100   -- mark - tinyint
    ), 
    (
        'ST02', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        80   -- mark - tinyint
    ),	  
    (
        'ST03', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        85   -- mark - tinyint
    ),
	
    (
        'ST04', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        70   -- mark - tinyint
    ), 
    (
        'ST05', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        60  -- mark - tinyint
    ),		   	
    (
        'ST06', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        90   -- mark - tinyint
    ),		
    (
        'ST07', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        80   -- mark - tinyint
    ),			
    (
        'ST08', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        90   -- mark - tinyint
    ),	
    (
        'ST09', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        60   -- mark - tinyint
    ),	  
    (
        'ST10', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        100   -- mark - tinyint
    ),	  					 
    (
        'ST11', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        95   -- mark - tinyint
    ),	  
    (
        'ST12', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        75   -- mark - tinyint
    ),	  
    (
        'ST13', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        55   -- mark - tinyint
    ),	  
    (
        'ST14', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        80   -- mark - tinyint
    ),	  
    (
        'ST15', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        65   -- mark - tinyint
    ),	  
    (
        'ST16', -- st_id - varchar(5)
        110,  -- sub_id - tinyint
        95   -- mark - tinyint
    )
GO	
