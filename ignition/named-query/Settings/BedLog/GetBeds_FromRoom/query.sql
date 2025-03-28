SELECT
	id, bedName 
FROM 
	lodging.Bed
Where
	roomId = :roomId
ORDER BY
	bedName