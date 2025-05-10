
GO
ALTER FUNCTION dbo.acalendar (@InputDate DATE)
RETURNS @monthes TABLE (
    sunday VARCHAR(10),
    monday VARCHAR(10),
    tuesday VARCHAR(10),
    wednesday VARCHAR(10),
    thursday VARCHAR(10),
    friday VARCHAR(10),
    saturday VARCHAR(10)
)
AS
BEGIN
    DECLARE @StartDate DATE = DATEFROMPARTS(YEAR(@InputDate), MONTH(@InputDate), 1);
    DECLARE @EndDate DATE = EOMONTH(@StartDate);

    -- Find first Sunday before or on the 1st of the month
    WHILE DATENAME(WEEKDAY, @StartDate) <> 'Sunday'
        SET @StartDate = DATEADD(DAY, -1, @StartDate);

    -- Find the last Saturday after or on the end of month
    WHILE DATENAME(WEEKDAY, @EndDate) <> 'Saturday'
        SET @EndDate = DATEADD(DAY, 1, @EndDate);

    DECLARE @CurrentDate DATE = @StartDate;

    WHILE @CurrentDate <= @EndDate
    BEGIN
        DECLARE @Sun VARCHAR(10) = NULL;
        DECLARE @Mon VARCHAR(10) = NULL;
        DECLARE @Tue VARCHAR(10) = NULL;
        DECLARE @Wed VARCHAR(10) = NULL;
        DECLARE @Thu VARCHAR(10) = NULL;
        DECLARE @Fri VARCHAR(10) = NULL;
        DECLARE @Sat VARCHAR(10) = NULL;

        -- Fill the values for 1 week (Sunday to Saturday)
        IF @CurrentDate BETWEEN DATEFROMPARTS(YEAR(@InputDate), MONTH(@InputDate), 1) AND EOMONTH(@InputDate)
            SET @Sun = CAST(DAY(@CurrentDate) AS VARCHAR);
        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);

        IF @CurrentDate BETWEEN DATEFROMPARTS(YEAR(@InputDate), MONTH(@InputDate), 1) AND EOMONTH(@InputDate)
            SET @Mon = CAST(DAY(@CurrentDate) AS VARCHAR);
        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);

        IF @CurrentDate BETWEEN DATEFROMPARTS(YEAR(@InputDate), MONTH(@InputDate), 1) AND EOMONTH(@InputDate)
            SET @Tue = CAST(DAY(@CurrentDate) AS VARCHAR);
        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);

        IF @CurrentDate BETWEEN DATEFROMPARTS(YEAR(@InputDate), MONTH(@InputDate), 1) AND EOMONTH(@InputDate)
            SET @Wed = CAST(DAY(@CurrentDate) AS VARCHAR);
        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);

        IF @CurrentDate BETWEEN DATEFROMPARTS(YEAR(@InputDate), MONTH(@InputDate), 1) AND EOMONTH(@InputDate)
            SET @Thu = CAST(DAY(@CurrentDate) AS VARCHAR);
        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);

        IF @CurrentDate BETWEEN DATEFROMPARTS(YEAR(@InputDate), MONTH(@InputDate), 1) AND EOMONTH(@InputDate)
            SET @Fri = CAST(DAY(@CurrentDate) AS VARCHAR);
        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);

        IF @CurrentDate BETWEEN DATEFROMPARTS(YEAR(@InputDate), MONTH(@InputDate), 1) AND EOMONTH(@InputDate)
            SET @Sat = CAST(DAY(@CurrentDate) AS VARCHAR);
        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);

        -- Insert one row for the week
        INSERT INTO @monthes (sunday, monday, tuesday, wednesday, thursday, friday, saturday)
        VALUES (@Sun, @Mon, @Tue, @Wed, @Thu, @Fri, @Sat);
    END

    RETURN;
END;



GO

SELECT * 
FROM dbo.acalendar(getdate());
