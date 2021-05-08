CREATE PROCEDURE fiboProc(@n int)
AS
BEGIN
	Select * from dbo.fiboFunc(@n);
END;