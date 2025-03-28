DECLARE @firstDayOfTheCurrentSeason as INT
DECLARE @YearStart as INT
DECLARE @YeareEnd as INT
DECLARE @todaysDate AS DATE

DECLARE @thisMonth int = Month(GetDate())
DECLARE @thisYear varchar(4) = Year(GetDate())
DECLARE @lastSeasonStartYear varchar(4) = CASE WHEN @thisMonth > 5 THEN (@thisYear - 1) ELSE (@thisYear - 2) END
DECLARE @lastSeasonId int
SELECT @lastSeasonId = s.id FROM shelter.Seasons s WHERE s.Seasons like @lastSeasonStartYear + '%'
SELECT @YearStart =  CAST(SUBSTRING(seasons, 1, 4)as INT) FROM shelter.Seasons where id = :seasonId
SELECT @YeareEnd =   CAST(SUBSTRING(seasons, 6, 9)as INT) FROM shelter.Seasons where id = :seasonId
SELECT @firstDayOfTheCurrentSeason = DATENAME(dayofyear , datefromparts(@YearStart, 11,1)) 
SELECT @todaysDate = CAST(GetDate() as Date)

Select x.RegisterForFuture, y.ActualAttendance, x.RegisterForFuture+ISNULL(y.ActualAttendance,0) as 'totalBedsWeekly', x.weekPerYear From
(select COALESCE(sum(totalBeds),0) as 'RegisterForFuture'
	,DATENAME(WEEK, DateAdd(DAY,dayOfYear, case when dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end)) as 'weekPerYear'

FROM
(SELECT dayOfYear,
CASE WHEN (DateAdd(DAY,dayOfYear, case when dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end) < @todaysDate) THEN 0
ELSE totalBeds END AS totalBeds 
FROM
[shelter].[Schedule]

 where 
	seasonId = :seasonId AND timeCancelled is NULL 
	-- AND DateAdd(DAY,dayOfYear, case when dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end) > GetDate()
	and DATENAME(MONTH, DateAdd(DAY,dayOfYear, case when dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end)) = :month
	) s
Group by
	DATENAME(WEEK, DateAdd(DAY,dayOfYear, case when dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end))
)x LEFT JOIN
(select count(schp.id) as 'ActualAttendance' 
	,DATENAME(WEEK, DateAdd(DAY,dayOfYear, case when dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end)) as 'weekPerYear'
FROM shelter.ScheduleParticipant schp 
WHERE 
	schp.seasonId = :seasonId AND schp.timeRetired is NULL
	and DATENAME(MONTH, DateAdd(DAY,dayOfYear, case when dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end)) = :month
Group by
	DATENAME(WEEK, DateAdd(DAY,dayOfYear, case when dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end))
)y ON x.weekPerYear = y.weekPerYear

order by CAST(x.weekPerYear AS INT)