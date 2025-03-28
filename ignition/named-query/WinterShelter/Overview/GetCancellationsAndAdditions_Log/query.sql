DECLARE @firstDayOfTheCurrentSeason as INT
DECLARE @YearStart as INT
DECLARE @YearEnd as INT
 
SELECT @YearStart =  CAST(SUBSTRING(seasons, 1, 4)as INT) FROM shelter.Seasons where id = :seasonId
SELECT @YearEnd =   CAST(SUBSTRING(seasons, 6, 9)as INT) FROM shelter.Seasons where id = :seasonId
SELECT @firstDayOfTheCurrentSeason = DATENAME(dayofyear , datefromparts(@YearStart, 11,1))

SELECT max(t2.id) as 'SID', t2.locationId, t2.locationName, t2.seasonId, count(t2.locationId) as 'nightsChange', CAST(t2.timeUpdated AS DATE) as 'day', t2.status, 
		CONCAT(case when max(t2.guests)*count(t2.locationId)=0 then '' when t2.status='Added' then '+' else '-' end ,max(t2.guests)*count(t2.locationId)) as 'registrationChange'

FROM (
	SELECT *, 
		(select count(schp.id) FROM shelter.ScheduleParticipant schp WHERE schp.seasonId = t1.seasonId AND schp.timeRetired is NULL and schp.locationId = t1.locationId and schp.scheduleId=t1.scheduleId)
		+ (Case when day > GetDate() then t1.totalBeds else 0 end) as 'RegistrationChange',
		t1.beds as 'guests'
	FROM
	(
	SELECT s.id, s.locationId, l.locationName, s.seasonId, ls.beds, s.totalBeds, s.id as scheduleId, ISNULL(s.timeUpdated, s.timeCreated) as 'timeUpdated',
	DateAdd(DAY,s.dayOfYear, case when s.dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YearEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end) as day,
	CASE 
	WHEN s.timeCancelled IS NULL AND s.timeCreated > datefromparts(@YearStart, 11,1) THEN 'Added'
	WHEN s.timeCancelled IS NOT NULL THEN  'Canceled'
	ELSE 'None'
	END AS status
	FROM
	shelter.Schedule s, shelter.location l, shelter.LocationSeasonal ls
	WHERE s.seasonId =  :seasonId 
	AND l.id = s.locationId
	AND ls.locationId= s.locationId AND ls.seasonId= s.seasonId
	AND ((s.timeCancelled IS NULL AND s.timeCreated > datefromparts(@YearStart, 11,1)) or s.timeCancelled >= datefromparts(@YearStart, 11,1))
	) t1
	WHERE  {dateFilter} 
	AND (:searchText is NULL or :searchText = '' or t1.locationName like  :searchText or t1.status like :searchText or t1.day like :searchText )
	AND (:statusType IS NULL or :statusType = '' or :statusType = 'both' or (t1.status = :statusType) )
)t2
GROUP BY CAST(t2.timeUpdated AS DATE), t2.status, t2.locationId, t2.locationName, t2.seasonId
ORDER BY t2.locationName, CAST(t2.timeUpdated AS DATE)


	 
