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
UPDATE dbo.tb
Subject SET sub_hours=101 WHERE sub_id=125
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