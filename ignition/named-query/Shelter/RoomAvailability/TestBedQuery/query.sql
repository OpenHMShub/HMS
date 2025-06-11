SELECT 
	id AS bedId,
	bedName
FROM lodging.Bed 
WHERE roomId = :roomId
AND timeRetired IS NULL