--Get Day, month and year from date
DECLARE @day_fromDate int, @month_fromDate int, @year_fromDate int
SET @day_fromDate = DAY(:startsOn_New)
SET @month_fromDate = MONTH(:startsOn_New)
SET @year_fromDate = YEAR(:startsOn_New)

--Update schedule evnt dates
UPDATE  [participant].[EventSchedule]
SET [day] = @day_fromDate,
	[year] = @year_fromDate,
	[month] = @month_fromDate,
	startsOn = :startsOn_New,
	endsOn = :endsOn_New
WHERE 
	eventId = :eventId
	AND startsOn = :startsOn
	AND endsOn = :endsOn

