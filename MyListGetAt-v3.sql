-- =============================================
-- Author:		<soncu>
-- Create date: <24.06.2013>
-- Description:	<T-Sql version of ListGetAt that supports 
-- negative position for backward index and multiple delimiters 
-- at once also empty element is optional with an argument>
-- =============================================
CREATE FUNCTION [dbo].[MyListGetAt]
(
	@string varchar(100),
	@position int,
	@delimiters varchar(50) = ',',
	@ignoreEmptySpaces bit	= 1
)
RETURNS varchar(100)
AS
BEGIN
	
	declare @str			varchar(100);
	declare @sub			varchar(100);
	declare @del			varchar(100);
	declare @ignoreEmpty	bit;
	declare @reverseOrd		bit;
	declare @count			int;
	declare @start			int;
	declare @end			int;
	declare @len			int;
	declare @retPos			int;

	set @str = @string;
	set @sub = '';
	set @del = @delimiters;
	set @ignoreEmpty = @ignoreEmptySpaces;
	set @reverseOrd = (case when @position < 0 then 1 else 0 end);
	set @count = 1;

	set @start = 1;
	set @retPos = ABS(@position);

	if @reverseOrd = 1
	begin
		set @str = REVERSE(@str);
	end

	if DATALENGTH(@del) > 1
	begin
		declare @d varchar(1);
		declare @i int

		set @d = left(@del, 1);
		set @i = 2;

		while @i <= DATALENGTH(@del)
		begin
			set @str = REPLACE(@str, SUBSTRING(@del, @i, 1), @d);
			set @i = @i + 1;
		end

		set @del = @d;
	end

	while @start <= DATALENGTH(@str) + 1
	begin
	
		set @end = CHARINDEX(@del, @str, @start);

		if @end = 0
		begin
			set @end = DATALENGTH(@str) + 1;
		end

		set @len = @end - @start;

		if @ignoreEmpty = 1 and @len = 0
		begin
			set @start = @start + 1;
			continue;
		end

		set @sub = SUBSTRING(@str, @start, @len);

		if @count = @retPos
		begin
			break;
		end

		set @start = @end + 1;

		set @count = @count + 1
	end

	RETURN (case when @reverseOrd = 1 then REVERSE(@sub) else @sub end);
END

GO