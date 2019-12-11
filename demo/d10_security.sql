use demo_sem1
go

CREATE TABLE encEmployees (
EmpName nvarchar(60) COLLATE Latin1_General_BIN2 ENCRYPTED WITH (
COLUMN_ENCRYPTION_KEY=Demo_Always_Encrypted_ColMKey, 
ENCRYPTION_TYPE = RANDOMIZED,  
ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256'),
UID varchar(11)
COLLATE Latin1_General_BIN2 ENCRYPTED WITH (
COLUMN_ENCRYPTION_KEY = Demo_Always_Encrypted_ColMKey,
ENCRYPTION_TYPE =  DETERMINISTIC,
ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256'),
Age int NULL
);  
GO


select * from encEmployees
go

insert encEmployees values
('anh dao', 'e10',63),
('binh van', 'e12',64)
go


-- tao bang chua cot data mask
drop table if exists encNewGroup

CREATE TABLE encNewGroup(
UID int IDENTITY PRIMARY KEY,
FNM varchar(100) MASKED WITH(FUNCTION='partial(1,"XXXXXXX",0)') NULL,
FatherName varchar(100) NOT NULL,
Mobile varchar(12) MASKED WITH(FUNCTION = 'default()') NULL,  
PersonalEmail varchar(100) MASKED WITH (FUNCTION = 'email()') NULL);
go

INSERT encNewGroup VALUES  
('Johnson', 'Flanagan', '12345688', 'JohnnsonFlan@yahoo.com'),
('Rossell', 'Geller', '76543218','RossGeller@hotmail.com'),  
('Brook', 'Darwin', '88956585', 'Brookdarwin@gmail.com'); 
go


/*
	create a new user and grant select permission on the encNewGroup table.
*/

--Create user reader
CREATE USER reader WITHOUT LOGIN
--Grant select permission to the user: reader
GRANT SELECT ON encNewGroup TO reader


EXECUTE AS USER = 'reader'  -- truy van voi quyen reader 
SELECT * FROM encNewGroup
REVERT						-- tro lai quyen dbo
GO

SELECT * FROM encNewGroup
go

-- remove mask
ALTER TABLE encNewGroup 
ALTER COLUMN PersonalEmail DROP MASKED
go


drop table if exists abc
go

create table abc (
id int identity primary key,
names varchar(10)
)

