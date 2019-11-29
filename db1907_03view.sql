USE db_1907
GO	

--Tạo bảng view chứa danh sách sv nam
CREATE VIEW vwNamSinh
AS
SELECT* FROM dbo.tbStudent WHERE st_gender=1
GO 

SELECT * FROM dbo.vwNamSinh
GO 

--Điều chỉnh năm sinh của sinh viên Hòa
UPDATE dbo.vwNamSinh
SET st_dob = '2006-12-24'
WHERE st_id LIKE 'ST19'
GO 

--Xem ds sinh viên
SELECT * FROM dbo.tbStudent
GO 

