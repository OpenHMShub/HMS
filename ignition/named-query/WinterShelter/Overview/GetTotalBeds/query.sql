DECLARE @firstDayOfTheCurrentSeason as INT
DECLARE @YearStart as INT
DECLARE @YeareEnd as INT
DECLARE @ActualAttendance as INT
DECLARE @RegisterForFuture as INT
DECLARE @BedThisSeason as INT

DECLARE @thisMonth int = Month(GetDate())
DECLARE @thisYear varchar(4) = Year(GetDate())
DECLARE @lastSeasonStartYear varchar(4) = CASE WHEN @thisMonth > 5 THEN (@thisYear - 1) ELSE (@thisYear - 2) END
DECLARE @lastSeasonId int
SELECT @lastSeasonId = s.id FROM shelter.Seasons s WHERE s.Seasons like @lastSeasonStartYear + '%'

SELECT @YearStart =  CAST(SUBSTRING(seasons, 1, 4)as INT) FROM shelter.Seasons where id = :seasonId
SELECT @YeareEnd =   CAST(SUBSTRING(seasons, 6, 9)as INT) FROM shelter.Seasons where id = :seasonId
SELECT @firstDayOfTheCurrentSeason = DATENAME(dayofyear , datefromparts(@YearStart, 11,1)) 

-- Get Bed This season count			
SET @ActualAttendance = (select count(schp.id) FROM shelter.ScheduleParticipant schp 
						WHERE schp.seasonId = :seasonId AND schp.timeRetired is NULL)

SET @RegisterForFuture = (select COALESCE(sum(s.totalBeds),0) FROM shelter.schedule s
						WHERE s.seasonId = :seasonId AND s.timeCancelled is NULL
						AND DateAdd(DAY,s.dayOfYear, case when s.dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end) > GetDate() )
SET @BedThisSeason = @ActualAttendance + @RegisterForFuture
select @BedThisSeason as 'BedsThisSeason'
