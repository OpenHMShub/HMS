SELECT
	r.id,
	CONCAT((select facilityName from lodging.Facility where id =r.facilityId), ' - ', r.roomName) as 'roomName'
FROM 
	lodging.Room r
WHERE
	r.timeRetired IS NULL AND
	r.facilityId in {facilityIdList}
ORDER BY
	CONCAT((select facilityName from lodging.Facility where id =r.facilityId), ' - ', r.roomName)