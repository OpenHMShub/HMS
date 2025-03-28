DECLARE @YearStart as INT, @YeareEnd as INT
SELECT @YearStart =  CAST(SUBSTRING(seasons, 1, 4)as INT) FROM shelter.Seasons where id = :seasonId
SELECT @YeareEnd =   CAST(SUBSTRING(seasons, 6, 9)as INT) FROM shelter.Seasons where id = :seasonId

SELECT  s.id as scheduleId, l.locationName, :selectedDate as 'dateSelected', s.totalBeds, s.genderId , g.genderAccepted as genderName, 
CASE WHEN s.timeCancelled IS NULL THEN 'Active' ELSE 'Canceled' end as isActive, 
CASE WHEN ls.smoking = 1 THEN 'Yes' ELSE 'No' end as smoking, 
CASE WHEN ls.accessible = 1 THEN 'Yes' ELSE 'No' end as accessible,
CASE WHEN ls.stairs = 1 THEN 'Yes' ELSE 'No' end as stairs, 
CASE WHEN ls.clothing = 1 THEN 'Yes' ELSE 'No' end as clothing, 
CASE WHEN ls.showers = 1 THEN 'Yes' ELSE 'No' end as showers, 
CASE WHEN ls.laundry = 1 THEN 'Yes' ELSE 'No' end as laundry, 
s.notes, ht.HostLocationType 
FROM
 shelter.Schedule s , shelter.gender g, shelter.location l,  shelter.LocationSeasonal ls, shelter.HostLocationType ht
 where 
  s.dayOfYear =  :dayOfYear 
 AND  s.seasonId =  :seasonId 
-- AND s.timeCancelled is NULL 
AND (s.timeCancelled is NULL OR s.timeCancelled >= datefromparts(@YearStart, 11,1))
AND ls.timeRetired is NULL
AND l.timeRetired IS NULL
AND s.locationId = ls.locationId 
AND s.seasonId = ls.seasonId
 AND s.locationId = l.id 
 AND l.id = ls.locationId
 AND s.genderId = g.id 
 AND ls.hostLocationTypeId = ht.id
 
 ORDER BY l.locationName
 