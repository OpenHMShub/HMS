SELECT COUNT(x.id)
FROM
(
	SELECT b.id 
	FROM lodging.Bed b, lodging.room r
	WHERE r.facilityId = :facilityId and r.id = b.roomId
	AND b.id IN (SELECT bedId from lodging.Reservation WHERE timeRetired is NULL and reservationExpiration IS NULL ) 
) x

    