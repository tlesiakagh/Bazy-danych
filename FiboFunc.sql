CREATE FUNCTION fiboFunc(@n int)
Returns  @output table(fiboSeries int)
AS
Begin
	DECLARE  @counter int = 2, @a int = 0, @b int = 1, @tmp int = 0;
	insert into @output values (@a),(@b);

	WHILE @counter < @n
	BEGIN
		SET @tmp = @b;
		SET @b = @a + @b;
		SET @a = @tmp;
		insert into @output values(@b);
		set @counter = @counter + 1;
	END

	Return;
End