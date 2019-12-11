use [sem2_demo]
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
('Nguyen Van An',12),
('Tran Van Chuong',45),
('Pham Ngoc Khanh',31),
('Le Hong Phuong',59)
go

--4. Retrieve data
select * from tbTemporalExample

--FOR SYSTEM_TIME FOR: retrieve data at specific time 
declare @DateTimeInHistory datetime2 = '2018-06-13 04:04:22.9594899'
select * from tbTemporalExample FOR SYSTEM_TIME AS OF @DateTimeInHistory

--FOR SYSTEM_TIME FROM ... TO
SELECT id, fullname, age, ValidFrom, ValidTo
FROM tbTemporalExample
FOR SYSTEM_TIME FROM '2018-06-13 04:04:22.100000' TO '2018-06-13 04:20:22.9999999'

-- FOR SYSTEM_TIME CONTAINED IN ()
SELECT id, fullname, age, ValidFrom, ValidTo
FROM tbTemporalExample
FOR SYSTEM_TIME CONTAINED IN ('2018-06-13 04:04:22.9594890', '2018-06-13 04:19:03.2020857')

-- FOR SYSTEM_TIME BETWEEN  
SELECT id, fullname, age, ValidFrom, ValidTo
FROM tbTemporalExample
FOR SYSTEM_TIME BETWEEN '2018-06-13 04:04:22' and '2018-06-13 04:20:00'


--5  insert more data
insert tbTemporalExample (fullname,age) values
('Ly Nhan Ai',20),
('Dinh Ngoc Hoang',43),
('Hoang Trong',30),
('Le Quan',19)
go