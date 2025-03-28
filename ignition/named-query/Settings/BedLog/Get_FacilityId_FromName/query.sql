SELECT 
	id 
FROM 
	lodging.Facility
WHERE 
	timeRetired is NULL AND
	facilityName in {shelterList}
	