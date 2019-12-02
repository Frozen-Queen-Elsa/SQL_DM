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

--Liệt kê kết quả môn C
SELECT *
FROM dbo.tbExam
WHERE sub_id=100
ORDER BY mark 
GO 

/*
	Viết store usp_updateC thực hiện việc tăng 2 điểm môn C đối với các kết quả < 40 đ 
	-Lệnh 1 : Liệt kê kết quả môn C / Sắp xếp theo điểm tăng dần
	-Lệnh 2 : Cập nhật : tăng 2 điểm cho các kết quả < 40 đ của môn C
	-Lệnh 3 : Liệt kê bảng môn C
*/
CREATE PROC usp_updateC AS
BEGIN
	--Liệt kê kết quả môn C / Sắp xếp theo điểm tăng dần
	SELECT *
	FROM dbo.tbExam
	WHERE sub_id=100
	ORDER BY mark  ;
	--Cập nhật : tăng 2 điểm cho các kết quả < 40 đ của môn C
	UPDATE dbo.tbExam
	SET mark=mark+2
	WHERE sub_id=100 AND mark<40;
	--Liệt kê bảng môn C
	SELECT *
	FROM dbo.tbExam
	WHERE sub_id=100
	ORDER BY mark  ;
END 
GO 

--Gọi / Thi hành công việc của store prodedure usp_updateC
EXEC dbo.usp_updateC
GO 

