DECLARE @YearStart as INT
SELECT @YearStart =  CAST(SUBSTRING(seasons, 1, 4)as INT) FROM shelter.Seasons where id = :seasonId


SELECT Dtpivot.locationId, l.locationName, Dtpivot.[CanceledNights] , Dtpivot.[AddedNights]
FROM
(
SELECT t1.locationId, count(status) as total, status
FROM
(
SELECT s.locationId,
CASE 
WHEN s.timeCancelled IS NULL AND s.timeCreated > datefromparts(@YearStart, 11,1) THEN 'AddedNights'
WHEN s.timeCancelled IS NOT NULL THEN  'CanceledNights'
ELSE 'None'
END AS status 
FROM
shelter.Schedule s
WHERE s.seasonId =  :seasonId AND ((s.timeCancelled IS NULL AND s.timeCreated > datefromparts(@YearStart, 11,1)) or s.timeCancelled >= datefromparts(@YearStart, 11,1))
) t1
GROUP BY locationId, status ) src
PIVOT
( MAX(total)
for status IN ([AddedNights], [CanceledNights])
) as Dtpivot
JOIN
shelter.location l ON Dtpivot.locationId = l.id AND l.timeRetired IS NULL
ORDER BY l.locationName
	 
