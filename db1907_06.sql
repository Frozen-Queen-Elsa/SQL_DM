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


SELECT * FROM dbo.tbExam
GO 

--Ví dụ về cấu trúc bẫy lỗi try-catch  :OK
BEGIN TRY
	SELECT * FROM tbExam WHERE mark<40
	UPDATE tbExam SET mark+=1 WHERE mark<40
	SELECT @@ROWCOUNT AS N'Số kết quả được thay đổi'
	SELECT * FROM dbo.tbExam WHERE mark <40
END TRY 
BEGIN CATCH
	SELECT ERROR_LINE() N'Dòng lỗi',ERROR_MESSAGE() N'Thanh báo lỗi' , ERROR_NUMBER() N'Mã số lỗi sai'
END CATCH 

--Ví dụ về cấu trúc bẫy lỗi try-catch  : Báo lỗi sai do cập nhật điểm >100
BEGIN TRY
	SELECT * FROM tbExam 
	UPDATE tbExam SET mark+=1 
	SELECT @@ROWCOUNT AS N'Số kết quả được thay đổi'
	SELECT * FROM dbo.tbExam 
END TRY 
BEGIN CATCH
	SELECT ERROR_LINE() N'Dòng lỗi',ERROR_MESSAGE() N'Thanh báo lỗi' , ERROR_NUMBER() N'Mã số lỗi sai'
END CATCH 