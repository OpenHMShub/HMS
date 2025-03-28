SELECT id as [value],  roomName AS [label]
FROM lodging.room
WHERE timeRetired IS NULL
ORDER BY facilityId, roomName