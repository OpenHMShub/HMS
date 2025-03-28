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

SELECT * FROM
(
SELECT sp.participantId , CONCAT(h.firstName, ' ', h.middleName, ' ', h.lastName) as participantName, CASE WHEN ISNULL(p.timeRetired,1) = 1 THEN 1 ELSE 0 end as isActive,
h.dob as BirthDate, h.hmis_number, g.genderName as gender, l.locationName, sp.dayOfYear, pd.veteranId, pd.veteran,
CASE 
WHEN sp.dayOfYear >= @startDayOfSeason AND sp.dayOfYear <=@endDayOfCurrentYear
THEN DateAdd(DAY,sp.dayOfYear,DateFromParts((@year1-1),12,31)) 
ELSE DateAdd(DAY,sp.dayOfYear,DateFromParts((@year2-1),12,31))  
END as checkinDate
FROM shelter.ScheduleParticipant sp, participant.participant p, 
	humans.human h, humans.gender g, shelter.location l, participant.Dashboard pd,
	shelter.locationSeasonal ls
WHERE sp.participantId = p.id AND sp.locationId = l.id
AND l.id = ls.locationId and ls.seasonId = :seasonId 
AND sp.participantId = pd.id
AND p.humanId = h.id and h.genderId = g.id
AND sp.seasonId =  :seasonId  
AND ( :hostLocationTypeId = -1 or  :hostLocationTypeId IS NULL or ls.hostLocationTypeId =  :hostLocationTypeId )
AND (:locationId = -1 OR sp.locationId = :locationId )
AND ( :genderId = -1 OR h.genderId = :genderId )
AND ( :veteranId = -1 OR pd.veteranId = :veteranId)
AND sp.timeRetired is null ) x
WHERE {search} AND  {dateRange} 
ORDER BY x.checkinDate desc
