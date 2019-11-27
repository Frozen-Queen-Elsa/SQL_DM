USE db_1907
GO

SELECT * FROM dbo.tbStudent
GO

SELECT st_id,st_name,st_dob FROM	dbo.tbStudent 
GO 

SELECT st_id,st_name,st_dob,YEAR(GETDATE())-YEAR(st_dob) AS Age FROM dbo.tbStudent
GO

SELECT * FROM dbo.tbExam
GO	

SELECT sub_id
FROM dbo.tbExam
GO 


--Danh sách các môn đã tổ chức thi (không có lặp lại những môn trùng)
SELECT DISTINCT sub_id
FROM dbo.tbExam
GO 

--Danh sách sinh viên
SELECT * FROM dbo.tbStudent
GO	

--Lấy 3 bạn sinh viên đầu tiên trong danh sách
SELECT TOP 3 *
FROM dbo.tbStudent
GO	

--Lấy 3 bạn sinh viên có chỉ số IQ cao nhất
SELECT *
FROM dbo.tbStudent
ORDER BY st_iq DESC	
GO	

SELECT TOP 6 WITH TIES *
FROM dbo.tbStudent
ORDER BY st_iq DESC 
GO 

--Liên kết danh sách sinh viên nam - Lưu vô bảng tbNamSV
SELECT * INTO tbNamSV
FROM tbStudent 
WHERE st_gender = 1
GO	   

--In danh sách nam sinh viên có trong bảng tbNamSV
SELECT * FROM dbo.tbNamSV
GO

--Liên kết danh sách sinh viên có chỉ số iq từ 100-130
SELECT *
FROM dbo.tbStudent
WHERE st_iq BETWEEN 100 AND 130
GO

--Liên kết các sinh viên có chỉ số IQ = 150 ,130 , 100 ,80
SELECT *
FROM dbo.tbStudent
WHERE (st_iq=150) OR (st_iq=130) OR (st_iq=100) OR (st_iq=80)
GO 

SELECT *
FROM dbo.tbStudent
WHERE st_iq IN (150,130,100,80)
GO 

--Liệt kê danh sách sinh viên có họ Nguyễn
SELECT *
FROM dbo.tbStudent
WHERE st_name LIKE N'Nguyễn%'
GO 

--Xem kết quả thi
SELECT * FROM dbo.tbExam
GO	

--Liên kết các môn đã tổ chức thi cùng với các lượt thi trong môn đó
SELECT * 
FROM dbo.tbExam 
ORDER BY sub_id
GO 


SELECT sub_id,COUNT(*) AS N'Số lượt thi'
FROM dbo.tbExam
GROUP BY sub_id
GO 

--Thống kê điểm cao nhất , thấp nhất , bình quân của từng môn thi 
SELECT sub_id,MAX(mark) AS N'Điểm cao nhất', MIN(mark) AS N'Điểm thấp nhất',AVG(mark) AS N'Điểm bình quân'
FROM dbo.tbExam
GROUP BY sub_id 
GO 
