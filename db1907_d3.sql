USE db_1907
GO

SELECT * FROM dbo.tbExam
GO 

--Tính điểm bình quân của mỗi môn học
SELECT sub_id,AVG(mark) AS N'Điểm Bình Quân'
FROM dbo.tbExam
GROUP BY sub_id 
GO 

--Tìm môn học có điểm bình quân > 60 đ
SELECT sub_id,AVG(mark) AS N'Điểm Bình Quân'
FROM dbo.tbExam
GROUP BY sub_id 
HAVING AVG(mark)>=60
GO 

--Tạo bảng tìm điểm trung bình và số lần thi với lệnh Group by with cube 
SELECT st_id,sub_id,AVG(mark) AS N'Điểm Bình Quân', COUNT(*) N'Số Lần Thi' 
FROM dbo.tbExam 
GROUP BY st_id,sub_id WITH CUBE
GO 

--Tạo bảng tìm điểm trung bình và số lần thi với lệnh Group by with rollup
SELECT st_id,sub_id,AVG(mark) AS N'Điểm Bình Quân', COUNT(*) N'Số Lần Thi' 
FROM dbo.tbExam 
GROUP BY st_id,sub_id WITH ROLLUP
GO 

--Tìm các sinh viên đã dự thi môn C (Dùng Subquery)
SELECT *
FROM dbo.tbExam
WHERE sub_id IN (SELECT sub_id FROM dbo.tbSubject WHERE sub_name LIKE '%C')
GO 

--Xem bảng điểm của sinh viên tên là Dung
SELECT *
FROM dbo.tbExam
WHERE st_id IN (SELECT st_id FROM dbo.tbStudent WHERE st_name LIKE '%Dung')
GO 

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
    (
        'ST17',        -- st_id - varchar(5)
        N'SNSD Seohyun',       -- st_name - nvarchar(60)
        0,      -- st_gender - bit
        '19911212', -- st_dob - date
        N'Seoul Korea',       -- st_add - nvarchar(100)
        159          -- st_iq - tinyint
    )
GO 

--Liệt kê danh sách các sinh viên chưa từng dự thi môn nào

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
    (
        'ST17',        -- st_id - varchar(5)
        N'SNSD Seohyun',       -- st_name - nvarchar(60)
        0,      -- st_gender - bit
        '19911212', -- st_dob - date
        N'Seoul Korea',       -- st_add - nvarchar(100)
        159          -- st_iq - tinyint
    )
GO 

SELECT *
FROM dbo.tbStudent a
WHERE NOT EXISTS(SELECT * FROM dbo.tbExam b WHERE a.st_id = b.st_id)
GO 

--Liệt kê tên các môn học chưa từng tổ chức thi
SELECT * 
FROM dbo.tbSubject a
WHERE NOT EXISTS(SELECT * FROM dbo.tbExam b WHERE b.sub_id = a.sub_id)
GO 

--Liệt kê tên các môn học đã từng tổ chức thi
SELECT * 
FROM dbo.tbSubject a
WHERE EXISTS(SELECT * FROM dbo.tbExam b WHERE b.sub_id = a.sub_id)
GO 

--In ra bảng kết quả thi của sinh viên bao gồm cột: Mã số , họ tên , mã số môn thi , điểm kết quả (Inner Join)
SELECT a.st_id,a.st_name,b.sub_id,b.mark
FROM dbo.tbStudent a JOIN dbo.tbExam b ON a.st_id=b.st_id
GO 

--In ra bảng kết quả thi của sinh viên bao gồm cột: Mã số , họ tên , mã số môn thi ,tên môn thi , điểm kết quả (Inner Join lồng)
SELECT a.st_id,a.st_name,c.sub_id,c.sub_name,b.mark
FROM (dbo.tbStudent a JOIN dbo.tbExam b ON a.st_id=b.st_id) JOIN dbo.tbSubject c ON b.sub_id = c.sub_id
GO 


--Liệt kê danh sách sinh viên chưa từng dự thi môn học nào hết	(Left Join)
SELECT a.*,b.mark 
FROM dbo.tbStudent a LEFT JOIN dbo.tbExam b ON a.st_id=b.st_id
WHERE b.mark IS NULL 
GO 

--Liệt kê các môn học chưa tổ chức thi (Right Join)
SELECT b.*,a.mark
FROM dbo.tbExam a RIGHT JOIN dbo.tbSubject b ON a.sub_id=b.sub_id
WHERE a.mark IS NULL 
GO 

--Thêm cột TeamLeader vô bảng sinh viên
ALTER TABLE dbo.tbStudent
	ADD leader  VARCHAR(5) NULL FOREIGN KEY REFERENCES dbo.tbStudent(st_id)
GO 

--Đã sử dụng tool trong SSMS nhập thêm dữ liệu Leader 


--In danh sách sinh viên và tên của các trưởng nhóm  (Sử dụng Self Join - Join đến chính bản thân của chính bản thân bảng đó)
SELECT * FROM dbo.tbStudent
GO 

SELECT a.st_id,a.st_name,a.st_gender,a.st_iq,b.st_id AS [Leader ID],b.st_name AS [Leader Name]
FROM dbo.tbStudent a LEFT JOIN dbo.tbStudent b ON a.leader=b.st_id
GO 


