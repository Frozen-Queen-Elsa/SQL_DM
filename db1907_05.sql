USE db_1907
GO	

SELECT * FROM dbo.tbStudent
GO
SELECT * FROM dbo.tbSubject
GO	

--Viết trigger insert : Không cho phép thêm 1 môn học mới có số tiết học >100
CREATE TRIGGER tgInsertSub
ON dbo.tbSubject
FOR INSERT AS
BEGIN 
	DECLARE @sotiet int
	SELECT @sotiet=sub_hours FROM Inserted
	IF (@sotiet>100)
	BEGIN
		PRINT N'Số tiết học không thể >100 . Từ chối thêm mới'
		ROLLBACK
	END	  	 
END 	 
GO 

--Kiểm thử trigger :
	--1. Tình huống thêm môn học mới có số tiết >100 : sẽ bị từ chối
INSERT dbo.tbSubject
    (
        sub_name,
        sub_fee,
        sub_hours
    )
VALUES
    (
        'XML', -- sub_name - varchar(30)
        180,  -- sub_fee - smallint
        101   -- sub_hours - tinyint
    )
GO 

SELECT * FROM dbo.tbSubject
GO 

	-- 2. Tình huống thêm môn học mới có số tiết >-10:ok !
INSERT dbo.tbSubject
    (
        sub_name,
        sub_fee,
        sub_hours
    )
VALUES
    (
        'XML', -- sub_name - varchar(30)
        80,  -- sub_fee - smallint
        10   -- sub_hours - tinyint
    )
GO	

SELECT * FROM dbo.tbSubject 
GO 

--Cập nhật lại số tiết học môn XML =101 !!!
UPDATE dbo.tbSubject 
SET sub_hours =101
WHERE sub_id=135  
GO 

SELECT * FROM dbo.tbSubject
GO 

--Viết trigger update : không cho phép thêm sửa số tiết của 1 môn học > 100
CREATE TRIGGER tgUpdateSub
ON dbo.tbSubject
FOR UPDATE AS
BEGIN
	IF(SELECT sub_hours FROM Inserted)>100
	BEGIN	
		PRINT N'Số tiết học không thể > 100 !! Từ chối thay đổi'
		ROLLBACK
	END 
END 
GO 

--Cập nhật lại số tiết môn học DM(125) =101 : Lỗi 
UPDATE dbo.tbSubject
SET sub_hours=101 
WHERE sub_id=125
GO 
SELECT * FROM dbo.tbSubject
GO 

--Viết trigger không cho phép đổi mã số sinh viên trên bảng sinh viên 
CREATE TRIGGER tgUpdateStudent
ON dbo.tbStudent
FOR UPDATE AS
BEGIN
	IF UPDATE(st_id)
	BEGIN
		PRINT N'Không thể đổi mã số sinh viên !!!'
		ROLLBACK
	END 
END 
GO 

SELECT * FROM dbo.tbStudent
GO	

--Kiểm tra trigger : Đổi mã số sinh viên ST21 ->ST31
UPDATE dbo.tbStudent 
SET st_id='ST31' 
WHERE st_id='ST21'
GO 

--Viết trigger delete : Không cho phép xóa kết quả thi môn lập trình C : (100)
CREATE TRIGGER tgDeleteExam ON dbo.tbExam 
FOR DELETE AS 
BEGIN
	IF(EXISTS (SELECT Deleted.sub_id FROM Deleted WHERE Deleted.sub_id=105))
	BEGIN 
		PRINT N'Không được phép xóa kết quả thi của môn học này !'
		ROLLBACK
	END 
END 
GO 

SELECT * 
FROM dbo.tbExam
WHERE st_id LIKE'ST01'
GO 

DELETE FROM dbo.tbExam
WHERE st_id = 'ST01'
GO 

--Instead Of Delete Trigger : Xóa toàn bộ các bảng có liên kết với dữ liệu ở bảng cần xóa .Xóa bảng lá trước xóa bảng gốc sau 
--Vd : Xóa Student A trong bảng tbStudent thì phải xóa cả thông tin điểm thi của Student A trong bảng tbExam sau đó xóa Student A trong bảng tbStudent

--Xem cấu trúc lệnh của trigger = sp_helptext
sp_helptext tgUpdateStudent
GO 

--Tổng kết cuối ngày
--Table để lưu dữ liệu 1 đối tượng
--View để truy vấn , cập nhật dữ liệu bảng gốc 1 cách có điều kiện	 ( tăng cường tính bảo mật hệ thống )
--Store để quản lý công việc hệ thống 1 cách tối ưu hơn	(tối ưu hóa công việc , đường truyền )
--Index để tăng tốc độ truy vấn / truy cập dữ liệu ( Giúp làm sao truy vấn dữ liệu 1 cách nhanh nhất) 

--Trigger để tạo 1 event tự động khi có 1 thao tác tác động trên bảng (Khi có các hoạt động Insert, Update, Delete ) ,ko có tham số  . 70% các hoạt động trên Trigger hoạt động DML ( Insert,Update,Dalete) . Còn lại thì sửa dụng trên ( Create,Alter,Drop ) 
-- Trigger có 2 loại là After Trigger hoặc Instead of Trigger