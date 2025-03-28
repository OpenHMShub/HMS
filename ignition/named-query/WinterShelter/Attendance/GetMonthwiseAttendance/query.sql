DECLARE @startDayOfSeason  int;
DECLARE @endDayOfCurrentYear int;
DECLARE @endDayOfSeason int;
DECLARE @year1 int;
DECLARE @year2 int;

SELECT @year1 = CAST(LEFT(Seasons, 4) as int), @year2 = CAST(RIGHT(Seasons,4) as int)
FROM
shelter.Seasons
where id =  :seasonId 

SELECT @startDayOfSeason =  DATENAME(dayofyear , datefromparts(@year1,5,1))
SELECT @endDayOfCurrentYear =  DATENAME(dayofyear , datefromparts(@year1,12,31))
SELECT @endDayOfSeason =  DATENAME(dayofyear , datefromparts(@year2,3,31))

SELECT count(participantId) as total, EOMONTH(checkinDate) as monthDate FROM
(
SELECT sp.participantId , CONCAT(h.firstName, ' ', h.middleName, ' ', h.lastName) as participantName, CASE WHEN p.timeRetired IS NULL THEN 1 ELSE 0 END AS 'isActive',
h.dob as 'BirthDate', g.genderName as 'gender', l.locationName, sp.dayOfYear, 
CASE 
WHEN sp.dayOfYear >= @startDayOfSeason AND sp.dayOfYear <=@endDayOfCurrentYear
THEN DateAdd(DAY,sp.dayOfYear,DateFromParts((@year1-1),12,31)) 
ELSE DateAdd(DAY,sp.dayOfYear,DateFromParts((@year2-1),12,31))  
END as checkinDate
FROM shelter.ScheduleParticipant sp, participant.Participant p, humans.Human h, participant.Dashboard d, 
shelter.location l, humans.Gender g, shelter.locationSeasonal ls
WHERE sp.participantId = p.id AND sp.locationId = l.id
AND l.id = ls.locationId and ls.seasonId = :seasonId
AND sp.participantId = d.id
AND p.humanId = h.id
AND h.genderId = g.id
AND sp.seasonId =  :seasonId  
AND ( :hostLocationTypeId = -1 or  :hostLocationTypeId IS NULL or ls.hostLocationTypeId =  :hostLocationTypeId )
AND (:locationId = -1 OR sp.locationId =  :locationId )
AND ( :genderId = -1 OR h.genderId =  :genderId )
AND ( :veteranId = -1 OR d.veteranId = :veteranId)
AND sp.timeRetired is null ) x
WHERE {search} AND  {dateRange} 
GROUP BY EOMONTH(checkinDate)
order by EOMONTH(checkinDate)
