SELECT 
	id 
FROM 
	shelter.Location
where 
	timeRetired IS NULL
	AND locationName = :locationName