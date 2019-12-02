--Kiểm tra 1 file có tồn tại không ?
--Kiểm tra file ko tồn tại
xp_fileexist 'D:\FILE.abc'
GO
--Kiểm tra file có tồn tại
xp_fileexist 'D:\Study\Aptech\Season1\SQL\Codes\Ass05.sql' 
GO

USE db_1907
GO 

--Tạo 1 store prodedure liệt kê 2 danh sách sinh viên
-- 1 . danh sách sinh viên nam
-- 2 . danh sách sinh viên nữ

CREATE PROC usp_SinhVien AS 
BEGIN
	--Lệnh 1  : Liệt kê danh sách sinh viên nam
	SELECT * 
	FROM dbo.tbStudent 
	WHERE st_gender=1 ;
	--Lệnh 2 : Liệt kê danh sách sinh viên nữ
	SELECT * 
	FROM dbo.tbStudent 
	WHERE st_gender=0 ;
END 
GO  

--Gọi / Thi hành công việc của store prodedure usp_SinhVien
EXEC dbo.usp_SinhVien
GO 
