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

-- Get currentSeason years
DECLARE @currentSeason_year1 as INT, @currentSeason_year2 as INT
SELECT @currentSeason_year1 = LEFT(Seasons,4) FROM shelter.Seasons WHERE id = :seasonId
SELECT @currentSeason_year2 = RIGHT(Seasons,4) FROM shelter.Seasons WHERE id = :seasonId

-- Get Total Beds per seasons	
SELECT
	seasonalBeds.seasonId as 'seasonId',
	seasonalBeds.seasons as 'seasons',
	CONCAT('''',RIGHT(LEFT(seasonalBeds.seasons,4),2),'''',RIGHT(seasonalBeds.seasons,2)) as 'seasonTitle',
	ISNULL(
		(case when seasonalBeds.seasonId = :seasonId 
		then (seasonalBeds.ActualAttendance + RegisterForFuture)
		else seasonalBeds.ActualAttendance end)
		,(SELECT totalBeds FROM shelter.Attendance_KPI_PreviousSeason where seasonId = seasonalBeds.seasonId)
		) as 'TotalBeds'
FROM(
	SELECT 
		se.id as 'seasonId',
		se.seasons as 'seasons',
		
		(select count(schp.id) as 'ActualAttendance' FROM shelter.ScheduleParticipant schp 
		WHERE schp.seasonId = se.id AND schp.timeRetired is NULL
		Group by schp.seasonId) as 'ActualAttendance',
		
		ISNULL((select COALESCE(sum(s.totalBeds),0) as 'RegisterForFuture' FROM shelter.schedule s
		WHERE s.seasonId = se.id AND s.timeCancelled is NULL
		AND DateAdd(DAY,s.dayOfYear, case when s.dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end) > GetDate()
		Group by s.seasonId
		),0) as 'RegisterForFuture'
		
		FROM 
			shelter.Seasons se
		WHERE 
			se.Seasons in (
				CONCAT(@currentSeason_year1-5,'-',@currentSeason_year2-5)
				,CONCAT(@currentSeason_year1-4,'-',@currentSeason_year2-4)
				,CONCAT(@currentSeason_year1-3,'-',@currentSeason_year2-3)
				,CONCAT(@currentSeason_year1-2,'-',@currentSeason_year2-2)
				,CONCAT(@currentSeason_year1-1,'-',@currentSeason_year2-1)
				,CONCAT(@currentSeason_year1,'-',@currentSeason_year2)
			)
	) seasonalBeds
ORDER By seasonalBeds.seasons


