---Determine the current, past and next season
DECLARE @thisMonth int = Month(GetDate())
DECLARE @thisYear varchar(4) = Year(GetDate())
DECLARE @thisSeasonStartYear varchar(4) = CASE WHEN @thisMonth > 5 THEN @thisYear ELSE (@thisYear - 1) END
---Determine the current, past and next season ID's
SELECT
	s.id
	,s.dayOfYear 
	,DateAdd(DAY,s.dayOfYear,DateFromParts(Year(GetDate())-1,12,31)) as DateFromDayOfYear
	,DATEPART(WEEKDAY,DateAdd(DAY,s.dayOfYear,DateFromParts(Year(GetDate())-1,12,31))) as DayOfWeek
	,DATENAME(WEEKDAY,DateAdd(DAY,s.dayOfYear,DateFromParts(Year(GetDate())-1,12,31))) as DayName
	,s.reservedBeds
	,s.genderId
	,s.totalBeds
	,s.seasonId
FROM
	shelter.Schedule s 
WHERE
	s.seasonId  = :seasonId 
order by DayName