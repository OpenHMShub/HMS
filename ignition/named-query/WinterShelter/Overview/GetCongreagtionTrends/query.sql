DECLARE @firstDayOfTheCurrentSeason as INT
DECLARE @YearStart as INT
DECLARE @YeareEnd as INT
SELECT @YearStart =  CAST(SUBSTRING(seasons, 1, 4)as INT) FROM shelter.Seasons where id = :seasonId
SELECT @YeareEnd =   CAST(SUBSTRING(seasons, 6, 9)as INT) FROM shelter.Seasons where id = :seasonId
SELECT @firstDayOfTheCurrentSeason = DATENAME(dayofyear , datefromparts(@YearStart, 11,1)) 

SELECT 
	l.id as 'locationId'
	,l.locationName
	,ls.seasonId
	,(select count(schp.id) FROM shelter.ScheduleParticipant schp WHERE schp.seasonId = :seasonId AND schp.locationId = ls.locationId AND schp.timeRetired is NULL) as 'ActualAttendance'	
	,(select COALESCE(sum(s.totalBeds),0) FROM shelter.schedule s
		WHERE s.seasonId = :seasonId AND s.timeCancelled is NULL AND s.locationId = ls.locationId 
		AND DateAdd(DAY,s.dayOfYear, case when s.dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end) > GetDate() ) as 'RegisterForFuture'	
	,CASE WHEN
	(select count(schp.id) FROM shelter.ScheduleParticipant schp WHERE schp.seasonId = :seasonId AND schp.locationId = ls.locationId AND schp.timeRetired is NULL)
		+(select COALESCE(sum(s.totalBeds),0) FROM shelter.schedule s
		WHERE s.seasonId = :seasonId AND s.timeCancelled is NULL AND s.locationId = ls.locationId 
		AND DateAdd(DAY,s.dayOfYear, case when s.dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end) > GetDate()
	) != 0 then 
	(select count(schp.id) FROM shelter.ScheduleParticipant schp WHERE schp.seasonId = :seasonId AND schp.locationId = ls.locationId AND schp.timeRetired is NULL)
		+(select COALESCE(sum(s.totalBeds),0) FROM shelter.schedule s
		WHERE s.seasonId = :seasonId AND s.timeCancelled is NULL AND s.locationId = ls.locationId 
		AND DateAdd(DAY,s.dayOfYear, case when s.dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end) > GetDate()
	)
	else ISNULL(tc.[totalBeds],0) end
	as 'totalBeds'	
FROM 
	shelter.Location l
	LEFT JOIN
		(select * from shelter.LocationSeasonal WHERE seasonId = :seasonId) ls ON ls.locationId = l.id
	LEFT JOIN
		[shelter].[TotalBedsPerCongregation] tc ON tc.[locationName] = l.[locationName] AND tc.seasonId = :seasonId
WHERE
	:congregationSearch = '' 
	OR :congregationSearch = NULL 
	OR l.locationName like '%' + :congregationSearch + '%'
ORDER BY
	locationName
