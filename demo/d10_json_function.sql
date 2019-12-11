use demo_sem1
go
-- demo using openjson()


DECLARE @JSON NVARCHAR (MAX) = N'{	
	"Name": null,
	"MaidenName": "Dawson",
	"UID": 9988776655,
	"CurrentID": false,
	"Skill": ["DevOps", "Python", "Perl"],
	"Regions": {"Country":"USA","Territory ":"North America"}
}'

SELECT * FROM OPENJSON(@json)


select 
	JSON_VALUE(@json, '$.MaidenName') as Name,  -- cased-sensitive
	JSON_VALUE(@json, '$.UID') as UID,
	JSON_VALUE(@json, '$.CurrentID') as ID,
	JSON_QUERY(@json, '$.Skill') as Skill,		-- get array /object
	JSON_QUERY(@json, '$.Regions') as Locations
GO


DECLARE @JSON2 NVARCHAR (MAX) = N'[
{	"Name": null, "MaidenName": "Dawson", "UID": 9988776655, "CurrentID": false,
	"Skill": ["DevOps", "Python", "Perl"],
	"Regions": {"Country":"USA","Territory":"North America"}
},
{	"Name": "Catherine", "MaidenName": "Kat", "UID": 9988776657, "CurrentID": true,
	"Skill": ["Designer", "Python", "Perl"],
	"Regions": {"Country":"CA","Territory":"Canada"}
}
]';

SELECT * FROM OPENJSON(@json2)
WITH (name varchar(20) '$.Name',  
        MaidenName nvarchar(50) '$.MaidenName', 
		UID dec  'strict $.UID',
		CurrentID bit '$.CurrentID',  
		Country nvarchar(10) '$.Regions.Country',
		Territory nvarchar(30) '$.Regions.Territory',
		Skills nvarchar(max) '$.Skill' as json) 
AS a
cross apply openjson(a.Skills) 
			with ( Skill nvarchar(8) '$' ) as b


SELECT name,  MaidenName, UID, CurrentID, Country, Territory, Skill
FROM OPENJSON(@json2)
WITH (name varchar(20) '$.Name',  
        MaidenName nvarchar(50) '$.MaidenName', 
		UID dec  'strict $.UID',
		CurrentID bit '$.CurrentID',  
		Country nvarchar(10) '$.Regions.Country',
		Territory nvarchar(30) '$.Regions.Territory',
		Skills nvarchar(max) '$.Skill' as json) 
AS a
outer apply openjson(a.Skills) 
			with ( Skill nvarchar(8) '$' ) as b




SELECT * FROM OPENJSON(@json2)
WITH (name varchar(20) '$.Name',  
        MaidenName nvarchar(50) '$.MaidenName', 
		UID dec  'strict $.UID',
		CurrentID bit '$.CurrentID',  
		Country nvarchar(10) '$.Regions.Country',
		Territory nvarchar(30) '$.Regions.Territory',
		Skills nvarchar(50) '$.Skill') ;				-- return null

-- output skill
SELECT * FROM OPENJSON(@json2)
WITH (name varchar(20) '$.Name',  
        MaidenName nvarchar(50) '$.MaidenName', 
		UID dec  'strict $.UID',
		CurrentID bit '$.CurrentID',  
		Country nvarchar(10) '$.Regions.Country',
		Territory nvarchar(30) '$.Regions.Territory',
		Skills nvarchar(max) '$.Skill' as json) 
outer apply openjson(Skills) 
			with ( Skill nvarchar(8) '$' ) as b





--


GO

