use db_1907
go

-- Example of Temporal Table
-- 0. Create table tbTemporalExample
if Object_ID('tbTemporalExample') is not null
	drop table tbTemporalExample
go


create table tbTemporalExample
(
	id int identity primary key,
	Fullname varchar(20),
	age dec(3,0)
);
go


-- 1. Add two datetime2 columns into table tbTemporalExample
alter table tbTemporalExample
ADD 
ValidFrom datetime2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
ValidTo datetime2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);
go

--2. Bat chuc nang danh so phien ban he thong
alter table tbTemporalExample
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.ExampleHistoryTable));
go


--3  insert data
insert tbTemporalExample (fullname,age) values
('Nguyen Dinh Huy',12),
('Hoang Minh Tam',45),
('Ngo Thi Doan Dung',31),
('Nguyen Ngoc Huyen',59)
go

--4. Retrieve data
select * from tbTemporalExample

--FOR SYSTEM_TIME FOR: retrieve data at specific time 
declare @DateTimeInHistory datetime2 = '2019-12-11 01:47:32.2084143'
select * from tbTemporalExample FOR SYSTEM_TIME AS OF @DateTimeInHistory

--FOR SYSTEM_TIME FROM ... TO
SELECT id, fullname, age, ValidFrom, ValidTo
FROM tbTemporalExample
FOR SYSTEM_TIME FROM '2019-01-01 00:04:22.100000' TO '2019-12-31 12:20:22.9999999'

-- FOR SYSTEM_TIME CONTAINED IN ()
SELECT id, fullname, age, ValidFrom, ValidTo
FROM tbTemporalExample
FOR SYSTEM_TIME CONTAINED IN ('2018-12-11 00:00:32.2084143', '2020-12-13 01:47:32.2084143')

-- FOR SYSTEM_TIME BETWEEN  
SELECT id, fullname, age, ValidFrom, ValidTo
FROM tbTemporalExample
FOR SYSTEM_TIME BETWEEN '2019-12-01 04:04:22' and '2019-12-13 04:20:00'


--5  insert more data
insert tbTemporalExample (fullname,age) values
('VO Hoang Trung',20),
('Nguyen Ngoc Thien Kim',43),
('Vo Minh Thu',30),
('Tran Hoa',19)
go