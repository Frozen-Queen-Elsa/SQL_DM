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

SELECT * FROM dbo.tbStudent
GO	