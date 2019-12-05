--Tạo 1 cơ sở dữ liệu , đặt tên db_vidu1
CREATE DATABASE db_vidu1;
GO	

--Tạo 1 cơ sở dữ liệu , đặt tên db_vidu2, bao gồm
-- File dữ liệu:
--		Tên db_vd2.mdf, trong thư mục : D:\Study\Aptech\Season1\SQL\Codes,
--		Kích thước ban đầu 8M, hết 8M xin thêm 10M , tối đa 100MB.
-- File nhật ký
--		Tên db_Vd2_log.ldf,trong thư mục : D:\Study\Aptech\Season1\SQL\Codes,
--		Kích thước ban đầu 8M, hết 8M xin thêm 10% , không giới hạn.

CREATE DATABASE db_Vidu2
ON	
( NAME='db_vd2',FILENAME='D:\Study\Aptech\Season1\SQL\Database\db_vd2.mdf',
  SIZE=8,FILEGROWTH=10,MAXSIZE=100
)
LOG ON	
( NAME='db_vd2_log',FILENAME='D:\Study\Aptech\Season1\SQL\Database\db_vd2_log.ldf',
  SIZE=8,FILEGROWTH=10%,MAXSIZE=unlimited
)
GO	

--Tạo 1 cơ sở dữ liệu có chứa file group
/*
	CSDL tên : db_vidu3, bao gồm
	- file dữ liệu :
	  db_vidu3.mdf,thư mục: D:\Study\Aptech\Season1\SQL\Database,kích thước 10MB
	  db_vidu3_2.mdf,thư mục: D:\Study\Aptech\Season1\SQL\Database,file group : Group 2
	- file nhật ký
	  db_vidu3_log.ldf,thư mục D:\Study\Aptech\Season1\SQL\Database, maxsize=100
*/

CREATE DATABASE db_vidu3
ON PRIMARY
(NAME='db_vidu3',FILENAME='D:\Study\Aptech\Season1\SQL\Database\db_vidu3.mdf',SIZE=10),
FILEGROUP GROUP2
(NAME='db_vidu3_2',FILENAME='D:\Study\Aptech\Season1\SQL\Database\db_vidu3_2.ndf')
LOG ON
(NAME='db_vidu3_log',FILENAME='D:\Study\Aptech\Season1\SQL\Database\db_vidu3.ldf',MAXSIZE=100)
GO	
	
DROP DATABASE db_vidu1 
GO
	
DROP DATABASE db_vidu2
GO

	
DROP DATABASE db_vidu3
GO

--Tạo CSDL ảnh của CSDL db_DDD (READ-ONLY)
CREATE DATABASE db_anh_ddd 
ON 
(NAME='db_DDD',FILENAME='D:\Study\Aptech\Season1\SQL\Database\db_anh_ddd.mdf')
AS SNAPSHOT OF db_DDD
GO	

USE db_anh_ddd
GO	

SELECT * FROM dbo.tbMonHoc
GO	

USE db_DDD
GO	
INSERT dbo.tbMonHoc
(
    mh_id,
    ten_mh,
    sotiet,
    hocphi
)
VALUES
(   'JXML',  -- mh_id - varchar(5)
    N'Jason&XML', -- ten_mh - nvarchar(50)
    10,   -- sotiet - tinyint
    150    -- hocphi - int
)
GO	