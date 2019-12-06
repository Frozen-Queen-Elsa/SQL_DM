USE	db_1907
GO 

--Viết FUNCTION tính giai thừa
CREATE FUNCTION ufn_giaithua(@n int)
RETURNS BIGINT 
AS
BEGIN
	DECLARE @kq BIGINT,@i int
	SET @kq=1
	SET @i=1
	WHILE (@i<=@n)
	BEGIN
		SET @kq*=@i
		SET @i+=1
    END 
	RETURN @kq
END
GO 

--Thực hiện hàm tính giai thừa của 5
DECLARE @kq BIGINT
SET @kq=dbo.ufn_giaithua(5)
PRINT N'Giai Thừa Cua 5 = ' + CAST(@kq AS VARCHAR(10))
GO 
