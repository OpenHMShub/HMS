
SELECT max(x.participantId) as participantId, max(x.participantName) as participantName, max(x.isActive) as isActive,
max(x.BirthDate) as BirthDate, max(x.gender) as gender, max(x.dayOfYear) as dayOfYear, count(x.participantId) as totalNights,
max(x.veteranId) as veteranId, max(veteran) as veteran
FROM(
SELECT sp.participantId , CONCAT(h.firstName, ' ', h.middleName, ' ', h.lastName) as participantName, CASE WHEN ISNULL(p.timeRetired,1) = 1 THEN 1 ELSE 0 end as isActive,
h.dob as BirthDate, g.genderName as gender, l.locationName, sp.dayOfYear, pd.veteranId, pd.veteran
FROM shelter.ScheduleParticipant sp, participant.participant p, humans.human h, humans.gender g, 
	shelter.location l, participant.Dashboard pd,
	shelter.locationSeasonal ls
WHERE sp.participantId = p.id AND sp.locationId = l.id
AND l.id = ls.locationId and ls.seasonId = :seasonId
AND sp.participantId = pd.id
AND p.humanId = h.id and h.genderId = g.id
AND sp.seasonId =  :seasonId  
AND ( :hostLocationTypeId = -1 or  :hostLocationTypeId IS NULL or ls.hostLocationTypeId =  :hostLocationTypeId )
AND ( :genderId = -1 OR h.genderId =  :genderId )
AND ( :veteranId = -1 OR pd.veteranId = :veteranId)
AND sp.timeRetired is null ) x
WHERE {search} 
GROUP BY x.participantId
ORDER BY max(x.participantName) asc
