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
	st_add VARCHAR(50)
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
    (N'Kim Dung'   -- person_name - nvarchar(60)   ),
    (N'Bảo Bảo'   -- person_name - nvarchar(60)	   ),
    (N'Ngọc Huyền'   -- person_name - nvarchar(60) ),
    (N'Hoàng Anh'   -- person_name - nvarchar(60)  ),
    (N'Minh Tâm'   -- person_name - nvarchar(60)   )
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