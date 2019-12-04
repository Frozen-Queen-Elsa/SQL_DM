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

--Thêm 1 sv nam vô view
INSERT dbo.vwNamSinh
    (
        st_id,
        st_name,
        st_gender,
        st_dob,
        st_add,
        st_iq,
        leader
    )
VALUES
    (
        'ST21',        -- st_id - varchar(5)
        N'Trần Thanh Tân',       -- st_name - nvarchar(60)
        1,      -- st_gender - bit
        '20000120', -- st_dob - date
        N'Sài Gòn',       -- st_add - nvarchar(100)
        80,         -- st_iq - tinyint
        NULL         -- leader - varchar(5)
    )
GO 

--Tạo view chứa danh sách các nữ sinh
CREATE VIEW vwNuSinh AS 
SELECT st_id,st_name,st_dob,st_add
FROM dbo.tbStudent
WHERE st_gender=0
GO 

--Truy vấn danh sách nữ sinh 
SELECT * FROM dbo.vwNuSinh
GO 

--Xem định nghĩa view Nam Sinh 
sp_helptext vwNamSinh
GO 

--Xem định nghĩa view Nữ Sinh 
sp_helptext vwNuSinh
GO 

--Sửa lại định nghĩa của view Nữ Sinh , bổ sung thêm cột tuổi (dùng hàm DateDiff)
ALTER VIEW dbo.vwNuSinh
AS
SELECT st_id AS N'Mã số SV',st_name N'Họ Tên SV',st_dob,DATEDIFF(yy,st_dob,GETDATE()) AS N'Tuổi SV',st_add AS N'Địa chỉ SV'
FROM dbo.tbStudent WHERE st_gender=0;
GO 

--Truy vấn danh sách nữ sinh 
SELECT * FROM dbo.vwNuSinh
GO

--Thêm 1 nam sinh vô view nữ sinh 
INSERT dbo.vwNuSinh
    (
        st_id,
        st_name,
        st_dob,
        st_add
    )
VALUES
    (
        'ST22',        -- st_id - varchar(5)
        N'Nguyễn Quốc Bảo',       -- st_name - nvarchar(60)
        '20001111', -- st_dob - date
        N'Hà Nội'        -- st_add - nvarchar(100)
    )
GO 

--Sửa lại định nghĩa vwNuSinh , bổ sung thêm điều kiện kiểm tra nhập liệu với CheckOption
ALTER VIEW vwNuSinh AS 
SELECT st_id AS N'Mã số SV',st_name N'Họ Tên SV',st_dob,DATEDIFF(yy,st_dob,GETDATE()) AS N'Tuổi SV',st_add AS N'Địa chỉ SV'
FROM dbo.tbStudent
WHERE st_gender=0
WITH CHECK OPTION
GO 

--Nếu thêm 1 sv Nam vào danh View Nữ Sinh thì Hệ Thống báo lỗi


--Muốn tạo bảng view không bị ảnh hưởng khi xóa bảng vật lý ta thêm lệnh with schemabinding
CREATE VIEW vwStudent WITH SCHEMABINDING
AS
SELECT st_id,st_name,st_gender FROM dbo.tbStudent
GO 

--Chuyển quyền sở hữu view là sp_changedbowner
