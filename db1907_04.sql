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
