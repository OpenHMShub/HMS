SELECT id,  roomName, gender, numberBeds
FROM lodging.Room
WHERE facilityId = :facilityId and timeRetired IS NULL
order by roomName