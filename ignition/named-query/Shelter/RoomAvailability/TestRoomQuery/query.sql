SELECT 
	id AS roomId,
	facilityId,
	roomName,
	numberBeds,
	isHandicapAccess,
	timeCreated,
	timeRetired,
	gender,
	smoking
FROM lodging.Room
WHERE facilityId = :shelterId 
AND timeRetired is null 

