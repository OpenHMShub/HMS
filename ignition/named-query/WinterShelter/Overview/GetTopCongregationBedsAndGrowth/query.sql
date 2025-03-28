DECLARE @firstDayOfTheCurrentSeason as INT
DECLARE @YearStart as INT
DECLARE @YeareEnd as INT
SELECT @YearStart =  CAST(SUBSTRING(seasons, 1, 4)as INT) FROM shelter.Seasons where id = :currentSeasonId
SELECT @YeareEnd =   CAST(SUBSTRING(seasons, 6, 9)as INT) FROM shelter.Seasons where id = :currentSeasonId
SELECT @firstDayOfTheCurrentSeason = DATENAME(dayofyear , datefromparts(@YearStart, 11,1)) 

SELECT 
	ls.locationId
	,l.locationName
	,sch.bedsProjected as 'BedsThisProjection'
	,CASE WHEN(
		(select count(schp.id) FROM shelter.ScheduleParticipant schp WHERE schp.seasonId = :currentSeasonId AND schp.locationId = ls.locationId AND schp.timeRetired is NULL)
		+ (select COALESCE(sum(s.totalBeds),0) FROM shelter.schedule s
		WHERE s.seasonId = :currentSeasonId AND s.timeCancelled is NULL AND s.locationId = ls.locationId 
		AND DateAdd(DAY,s.dayOfYear, case when s.dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end) > GetDate() )
	) != 0 then
	(
		(select count(schp.id) FROM shelter.ScheduleParticipant schp WHERE schp.seasonId = :currentSeasonId AND schp.locationId = ls.locationId AND schp.timeRetired is NULL)
		+ (select COALESCE(sum(s.totalBeds),0) FROM shelter.schedule s
		WHERE s.seasonId = :currentSeasonId AND s.timeCancelled is NULL AND s.locationId = ls.locationId 
		AND DateAdd(DAY,s.dayOfYear, case when s.dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end) > GetDate() )
	)
	else ISNULL(tc.[totalBeds],0) end 
	as 'totalBeds'					
	,CASE WHEN(
		(select count(schp.id) FROM shelter.ScheduleParticipant schp WHERE schp.seasonId = :currentSeasonId AND schp.locationId = ls.locationId AND schp.timeRetired is NULL)
		+ (select COALESCE(sum(s.totalBeds),0) FROM shelter.schedule s
		WHERE s.seasonId = :currentSeasonId AND s.timeCancelled is NULL AND s.locationId = ls.locationId 
		AND DateAdd(DAY,s.dayOfYear, case when s.dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end) > GetDate() )
	) != 0 then
	(ROUND(CASE WHEN (schprev.PrevSeasonActual IS NULL OR schprev.PrevSeasonActual = 0) THEN sch.bedsProjected 
		ELSE (CAST((sch.bedsProjected-schprev.PrevSeasonActual) AS FLOAT)/schprev.PrevSeasonActual)*100 END , 0)
	)
	else 
	(ROUND(CASE WHEN (tcprev.totalBeds IS NULL OR tcprev.totalBeds = 0) THEN tc.totalBeds 
		ELSE (CAST((tc.totalBeds-tcprev.totalBeds) AS FLOAT)/tcprev.totalBeds)*100 END , 0)
	)
	end AS 'PercentBedGrowth'
FROM 
	shelter.LocationSeasonal ls
	LEFT JOIN
		shelter.Location l ON ls.locationId = l.id
	LEFT JOIN (SELECT * FROM shelter.LocationSeasonal WHERE ID IN (Select min(id) FROM shelter.LocationSeasonal 
				WHERE seasonID = :lastSeasonId GROUP BY locationId)) lsp ON l.id = lsp.locationid
	LEFT JOIN ( SELECT locationId, seasonId , sum(totalBeds) as bedsProjected
		FROM shelter.Schedule 
		WHERE timeCancelled is NULL 
		GROUP BY locationId, seasonId ) sch ON ls.seasonId = sch.seasonId AND ls.locationId = sch.locationId
	LEFT JOIN ( SELECT locationId, seasonId , count(id) as PrevSeasonActual
		FROM shelter.ScheduleParticipant 
		WHERE timeRetired is NULL
		GROUP BY locationId, seasonId )schprev ON lsp.seasonId = schprev.seasonId AND lsp.locationId = schprev.locationId
	LEFT JOIN
		[shelter].[TotalBedsPerCongregation] tc ON tc.[locationName] = l.[locationName] AND tc.seasonId = :currentSeasonId
	LEFT JOIN
		[shelter].[TotalBedsPerCongregation] tcprev ON tcprev.[locationName] = l.[locationName] AND tcprev.seasonId = :lastSeasonId
WHERE 
	ls.seasonId = :currentSeasonId
	AND sch.bedsProjected IS NOT NULL AND sch.bedsProjected > 0
ORDER BY
	l.locationName