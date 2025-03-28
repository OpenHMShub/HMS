SELECT CASE 
	WHEN EXISTS(SELECT 1 FROM lodging.BedLog WHERE bedId = :bedId and eventEnd is NULL) THEN 1
    ELSE 0 END AS 'bedOccupied'
    