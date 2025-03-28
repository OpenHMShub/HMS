--SELECT Count(*) FROM
--(
SELECT 
	s.locationId as LocationId
	,s.bedsProjected as BedsProjectedThisSeason 
	,p.bedsActual as BedsLastSeason 
	,(s.bedsProjected-p.bedsActual) as BedGrowth
	,CASE 
		WHEN (p.bedsActual IS NULL OR p.bedsActual = 0) THEN s.bedsProjected 
		ELSE (CAST((s.bedsProjected-p.bedsActual) AS FLOAT)/p.bedsActual)*100 END AS PercentBedGrowth
FROM
	(SELECT * FROM shelter.LocationSeasonal where seasonId = :CurrentSeasonId) s
LEFT JOIN
	(SELECT * FROM shelter.LocationSeasonal where seasonId = :lastSeasonId) p
ON 
	s.locationId = p.locationId
--) a
--WHERE PercentBedGrowth :PercentCondition --< = -10