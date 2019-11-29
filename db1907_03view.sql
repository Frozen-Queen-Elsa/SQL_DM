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


