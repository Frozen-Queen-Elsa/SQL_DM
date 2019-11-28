create database BookOnline
on
(name = 'Book_dat', filename = 'D:\Study\Aptech\Season1\SQL\Database\BookOnline.mdf',
	size = 5, filegrowth = 15%, maxsize = unlimited)
log on 
(name = 'Book_log', filename = 'D:\Study\Aptech\Season1\SQL\Database\BookOnline.ldf', 
size = 2, filegrowth = 1, maxsize = 10)
go

create database SalesOnline 
on primary
(name = 'Sale_dat', filename= 'D:\Study\Aptech\Season1\SQL\Database\SalesOnline.mdf',
size= 5, filegrowth= 15% ,maxsize=unlimited),
filegroup Group2
(name = 'Sale2_dat', filename = 'D:\Study\Aptech\Season1\SQL\Database\SalesOnline.ndf',
	size = 5, filegrowth = 5, maxsize = 20),
filegroup Group3
(name = 'Sale3_dat', filename = 'D:\Study\Aptech\Season1\SQL\Database\SalesOnline.edf',
	size = 5, filegrowth = 5, maxsize = 20)
log on
(name = 'Sales_log', filename = 'D:\Study\Aptech\Season1\SQL\Database\SalesOnline.ldf',
	size = 2, filegrowth = 10%, maxsize = 100)
go

create database UnitedAir1
on primary 
( name = 'UnitedAir1_dat', filename = 'D:\Study\Aptech\Season1\SQL\Database\UnitedAir1.mdf',
size = 5, filegrowth = 15%, maxsize = 10),
( name = 'UnitedAir2_dat', filename = 'D:\Study\Aptech\Season1\SQL\Database\UnitedAir1.mdf',
size = 5, filegrowth = 15%, maxsize = 10),
filegroup UnitedAirGroup1 
(name = 'UnitedAirGrp1F1', filename = 'D:\Study\Aptech\Season1\SQL\Database\UnitedAirGroup1.ndf'),
(name = 'UnitedAirGrp1F2', filename = 'D:\Study\Aptech\Season1\SQL\Database\UnitedAirGroup1.ndf'),

filegroup UnitedAirGroup2 
(name = 'UnitedAirGrp2F1', filename = 'D:\Study\Aptech\Season1\SQL\Database\UnitedAirGroup2.edf'),
(name = 'UnitedAirGrp2F2', filename = 'D:\Study\Aptech\Season1\SQL\Database\UnitedAirGroup2.edf')
go

ALTER DATABASE BookOnline MODIFY NAME = SalesOnline
go  

drop database BookOnline
go

drop database SalesOnline
go

drop database UnitedAir1
go


