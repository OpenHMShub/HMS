SELECT COUNT(x.id)
FROM
(
	SELECT id 
	FROM lodging.Bed 
	WHERE roomId = :roomId 
	AND id IN (SELECT bedId from lodging.Reservation WHERE timeRetired is NULL and reservationExpiration IS NULL ) 
) x

    