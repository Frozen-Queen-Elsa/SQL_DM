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
	WHERE sub_id=100 AND mark<40 ;
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

/*
	Viết store usp_updateMark thực hiện việc tăng 2 điểm với 1 môn thi bất kỳ(tham số đầu vào) đối với các kết quả < 40 đ 
	-Lệnh 1 : Liệt kê kết quả môn đk yêu cầu / Sắp xếp theo điểm tăng dần
	-Lệnh 2 : Cập nhật : tăng 2 điểm cho các kết quả < 40 đ của 1 môn bất kỳ(tham số đầu vào)
	-Lệnh 3 : Liệt kê bảng môn yêu cầu
*/
CREATE PROCEDURE usp_updateMark	
					@ma_monhoc TINYINT 
AS
BEGIN
	--Lệnh 1 : Liệt kê kết quả môn đk yêu cầu / Sắp xếp theo điểm tăng dần
	SELECT * 
	FROM dbo.tbExam
	WHERE sub_id=@ma_monhoc 
	ORDER BY mark  ;
	--Lệnh 2 : Cập nhật : tăng 2 điểm cho các kết quả < 40 đ của 1 môn bất kỳ(tham số đầu vào)
	UPDATE dbo.tbExam
	SET mark+=2
	WHERE sub_id=@ma_monhoc	AND mark<40 ;
	--Lệnh 3 : Liệt kê bảng môn yêu cầu
	SELECT * 
	FROM dbo.tbExam
	WHERE sub_id=@ma_monhoc 
	ORDER BY mark  ;
END 
GO 

--Gọi / Thi hành công việc của store prodedure usp_updateMark :cập nhật điểm môn HTML (110)
EXEC dbo.usp_updateMark  105
GO 

SELECT *
FROM dbo.tbExam
WHERE sub_id=105
ORDER BY mark
GO 


--Dùng Rowcount để kiểm tra số dòng đã cập nhật !! Chú ý là phải chạy cùng lúc và viết ngay sau đó , ko có Go chen giữa!!
UPDATE dbo.tbExam 
SET mark+=2
WHERE mark<40 AND sub_id=100   

SELECT @@rowcount AS N'Số dòng cập nhật'
GO 


/*
	Viết store usp_updateMarkPoint thực hiện việc thay đổi điểm với 1 môn thi bất kỳ(được cung cấp theo tham số đầu vào)
	 đối với các kết quả < 40 đ - Sau đó cho biết có bao nhiêu kết quả đã được thay đổi
	-Lệnh 1 : Liệt kê kết quả môn đk yêu cầu / Sắp xếp theo điểm tăng dần
	-Lệnh 2 : Cập nhật : cập nhật điểm cho các kết quả < 40 đ của 1 môn bất kỳ(tham số đầu vào)
	-Lệnh 3 : Liệt kê bảng môn yêu cầu
*/
CREATE PROCEDURE usp_updateMarkPoint	
					@ma_monhoc TINYINT,@diemthi INT,@sodong INT OUTPUT  
AS
BEGIN
	--Lệnh 1 : Liệt kê kết quả môn đk yêu cầu / Sắp xếp theo điểm tăng dần
	SELECT * 
	FROM dbo.tbExam
	WHERE sub_id=@ma_monhoc 
	ORDER BY mark  ;

	--Lệnh 2 : Cập nhật : cập nhật điểm cho các kết quả < 40 đ của 1 môn bất kỳ(tham số đầu vào)
	UPDATE dbo.tbExam
	SET mark+=@diemthi
	WHERE sub_id=@ma_monhoc	AND mark<40 ;

	--Cập nhật biến OUTPUT
	SET @sodong = @@ROWCOUNT 

	--Lệnh 3 : Liệt kê bảng môn yêu cầu
	SELECT * 
	FROM dbo.tbExam
	WHERE sub_id=@ma_monhoc 
	ORDER BY mark  ;
END 
GO 

--Chạy Store usp_updateMarkPoint tăng 3 điểm thi cho môn HTML
DECLARE @soKQ INT;
EXEC dbo.usp_updateMarkPoint
    @ma_monhoc = 105,          -- tinyint
    @diemthi = 3,            -- tinyint
    @sodong = @soKQ OUTPUT -- int
SELECT @soKQ AS N'Số lương bài thi đã được thay điểm'
GO 

--Xem nội dung đã được viết cho store [usp_updateMarkPoint]
sp_helptext usp_updateMarkPoint
GO 

--Sử dụng WITH ENCRYPTION/RECOMPILE	 (ghi sau biến @ và ghi trước AS)
--ENCRYPTION : Nội dung store ẩn đi không cho ai xem hết ( Nhớ lưu lại file script ) 
--RECOMPLIE :  Truy vấn sẽ không được lưu ở bộ nhớ đệm (cache) cho thủ tục này.
--EXECUTE AS clause: Xác định ngữ cảnh bảo mật để thực thi thủ tục.


ALTER PROC usp_SinhVien 
WITH ENCRYPTION
AS 
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

-- Xem phần định nghĩa của usp_SinhVien 
sp_helptext usp_SinhVien
GO 

--Tổng kết cuối ngày
--Table để lưu dữ liệu 1 đối tượng
--View để truy vấn , cập nhật dữ liệu bảng gốc 1 cách có điều kiện	 ( tăng cường tính bảo mật hệ thống )
--Store để quản lý công việc hệ thống 1 cách tối ưu hơn	(tối ưu hóa công việc , đường truyền )
--Index để tăng tốc độ truy vấn / truy cập dữ liệu ( Giúp làm sao truy vấn dữ liệu 1 cách nhanh nhất) 