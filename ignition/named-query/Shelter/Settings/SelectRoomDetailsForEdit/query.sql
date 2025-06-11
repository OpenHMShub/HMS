SELECT numberBeds, isHandicapAccess, gender, smoking 
FROM lodging.Room
WHERE facilityId = :facilityId and id = :roomId