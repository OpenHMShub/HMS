SELECT  SUM( s.totalBeds) as totalBeds
FROM
 shelter.Schedule s , shelter.location l,  shelter.LocationSeasonal ls
 where 
  s.dayOfYear =  :dayOfYear 
 AND  s.seasonId =  :seasonId 
 AND s.timeCancelled is NULL 
AND ls.timeRetired is NULL
AND l.timeRetired IS NULL
AND s.locationId = ls.locationId 
AND s.seasonId = ls.seasonId
 AND s.locationId = l.id 
 AND l.id = ls.locationId

 
 