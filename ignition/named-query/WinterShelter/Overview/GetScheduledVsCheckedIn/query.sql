DECLARE @todayDayOfTheYear as INT
DECLARE @firstDayOfTheCurrentSeason as INT
DECLARE @YearStart as INT
DECLARE @YeareEnd as INT
DECLARE @todaysDate AS DATE

SELECT @todayDayOfTheYear = DATENAME(dayofyear , GetDate()) 
SELECT @YearStart =  CAST(SUBSTRING(seasons, 1, 4)as INT) FROM shelter.Seasons where id = :seasonId
SELECT @YeareEnd =   CAST(SUBSTRING(seasons, 6, 9)as INT) FROM shelter.Seasons where id = :seasonId
SELECT @firstDayOfTheCurrentSeason = DATENAME(dayofyear , datefromparts(@YearStart, 11,1)) 
SELECT @todaysDate = CAST(GetDate() as Date)

SELECT s1.DateFromDayOfYear, DATENAME(WEEKDAY,s1.DateFromDayOfYear) as dayName,
SUM(s1.totalBeds) as scheduled, SUM(COALESCE(sp.totalParticipants,0)) as checkedIn, 
SUM(( COALESCE(sp.totalParticipants,0) - s1.totalBeds)) as delta, 
DATEPART(WEEK,s1.DateFromDayOfYear) as weekNumber, 
DATEPART(dw,s1.DateFromDayOfYear) as dayNumber, 
CASE WHEN s1.DateFromDayOfYear < @todaysDate THEN COUNT(DISTINCT(sp.locationId)) 
ELSE COUNT(DISTINCT(s1.locationId)) END as noOfCongregations,
CASE WHEN s1.DateFromDayOfYear < @todaysDate THEN SUM(COALESCE(sp.totalParticipants,0))  
ELSE SUM(s1.totalBeds) END as projection,
CASE WHEN s1.DateFromDayOfYear < @todaysDate THEN COUNT((sp.locationId)) 
ELSE COUNT((s1.locationId)) END as noOfCongregationsNonUnique
FROM
(
SELECT
	l.id as 'locationId',
	s.id as 'scheduleId',
	s.seasonId as 'seasonId',
	s.totalBeds,
	
	s.dayOfYear , 
	DateAdd(DAY,s.dayOfYear, case when s.dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end) as DateFromDayOfYear ,
	s.timeRetired, s.timeCreated, s.timeCancelled
	
FROM shelter.Location l, shelter.Schedule s
WHERE l.timeRetired is NULL 
AND s.seasonId = :seasonId AND s.timeCancelled IS NULL
AND l.id = s.locationId  ) s1
-- ORDER BY s.dayOfYear
LEFT JOIN
(SELECT COUNT(participantId) as totalParticipants, dayOfYear , scheduleId, locationId 
	 FROM shelter.ScheduleParticipant 
	 WHERE timeRetired IS NULL GROUP BY scheduleId, locationId, dayOfYear) sp
ON s1.locationId = sp.locationId AND s1.scheduleId = sp.scheduleId and s1.dayOfYear = sp.dayOfYear
WHERE MONTH(s1.DateFromDayOfYear) =  :month 
GROUP BY s1.DateFromDayOfYear, DATENAME(WEEKDAY,s1.DateFromDayOfYear)
ORDER BY s1.DateFromDayOfYear
	 
