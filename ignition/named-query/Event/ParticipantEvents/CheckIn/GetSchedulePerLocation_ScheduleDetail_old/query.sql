DECLARE @minimumTimeCreated AS DATETIME
DECLARE @todayDayOfTheYear as INT
DECLARE @lastDayOfTheCurrentYear as INT
DECLARE @firstDayOfTheCurrentSeason as INT

SELECT @todayDayOfTheYear = DATENAME(dayofyear , GetDate()) 
SELECT @lastDayOfTheCurrentYear = DATENAME(dayofyear , datefromparts(YEAR(GETDATE()), 12,31)) 
SELECT @firstDayOfTheCurrentSeason = DATENAME(dayofyear , datefromparts(YEAR(GETDATE()), 11,1)) 

SELECT @minimumTimeCreated = MIN(timeCreated)
FROM shelter.Schedule 
WHERE locationId = :locationId AND seasonId =  :seasonId 

SELECT s1.locationId, s1.scheduleId, s1.seasonId, s1.totalBeds, s1.gender,s1.genderId, s1.dayOfYear,
CASE 
WHEN s1.timeCancelled IS NULL AND COALESCE(sp.totalParticipants,0) > 0 and s1.dayOfYear =  :todayDayOfTheYear THEN 'Checked-In'
WHEN s1.timeCancelled IS NULL AND COALESCE(sp.totalParticipants,0) > 0 and s1.dayOfYear <  :todayDayOfTheYear THEN 'Completed'
WHEN s1.timeCancelled IS NULL AND COALESCE(sp.totalParticipants,0) = 0 and s1.dayOfYear <  @todayDayOfTheYear AND s1.dayOfYear > @firstDayOfTheCurrentSeason AND @todayDayOfTheYear < @lastDayOfTheCurrentYear THEN 'No-Show'
WHEN s1.timeCancelled IS NULL AND COALESCE(sp.totalParticipants,0) = 0 and s1.dayOfYear <  @todayDayOfTheYear AND s1.dayOfYear < @firstDayOfTheCurrentSeason AND @todayDayOfTheYear < @lastDayOfTheCurrentYear THEN 'Scheduled'
WHEN s1.timeCancelled IS NULL AND s1.timeCreated > @minimumTimeCreated and s1.timeCreated > datefromparts(YEAR(GETDATE()), 11,1) THEN 'Addition'
WHEN s1.timeCancelled IS NULL AND COALESCE(sp.totalParticipants,0) = 0 and s1.dayOfYear >=  :todayDayOfTheYear THEN 'Scheduled'
WHEN s1.timeCancelled IS NOT NULL THEN 'Canceled'
END AS status 
FROM
(
SELECT
	l.id as 'locationId',
	s.id as 'scheduleId',
	s.seasonId as 'seasonId',
	s.totalBeds,
	CASE WHEN g.genderAccepted = 'Men Only' THEN 'Male'
	WHEN g.genderAccepted = 'Women Only' THEN 'Female'
	WHEN g.genderAccepted = 'Men or Women on Different Nights' THEN 'Male or Female'
	WHEN g.genderAccepted = 'Men & Women Together' THEN 'Male and Female' END AS gender,
	g.id as 'genderId',
	s.dayOfYear , s.timeRetired, s.timeCreated, s.timeCancelled
	
FROM shelter.Location l, shelter.Schedule s, shelter.Gender g 
WHERE l.timeRetired is NULL 
AND s.seasonId = :seasonId 
AND l.id = :locationId AND l.id = s.locationId AND g.id = s.genderId ) s1
-- ORDER BY s.dayOfYear
LEFT JOIN
(SELECT COUNT(participantId) as totalParticipants, dayOfYear , scheduleId, locationId 
	 FROM shelter.ScheduleParticipant 
	 WHERE timeRetired IS NULL GROUP BY scheduleId, locationId, dayOfYear) sp
ON s1.locationId = sp.locationId AND s1.scheduleId = sp.scheduleId and s1.dayOfYear = sp.dayOfYear
ORDER BY s1.dayOfYear
	 
