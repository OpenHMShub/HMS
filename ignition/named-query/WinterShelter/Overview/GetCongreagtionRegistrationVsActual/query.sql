
SELECT 
	ls.locationId
	,l.locationName
	,lr.bedsProjected as 'registered'
	,ls.bedsProjected as 'actual'
	,(ls.bedsProjected - lr.bedsProjected) as 'delta'
FROM 
	shelter.LocationSeasonal ls
	LEFT JOIN
		shelter.LocationRegistrationDetails lr ON ls.locationId = lr.locationId and ls.seasonId = lr.seasonId
	LEFT JOIN
		shelter.Location l ON ls.locationId = l.id
	LEFT JOIN ( SELECT locationId, seasonId , sum(totalBeds) as bedsProjected
		FROM shelter.Schedule 
		WHERE timeCancelled is NULL 
		GROUP BY locationId, seasonId ) sch ON ls.seasonId = sch.seasonId AND ls.locationId = sch.locationId
WHERE 
	ls.seasonId = :seasonId
	AND sch.bedsProjected IS NOT NULL AND sch.bedsProjected > 0
ORDER BY
	l.locationName