SELECT COUNT(x.id)
FROM
(
	SELECT b.id 
	FROM lodging.Bed b, lodging.room r
	WHERE r.facilityId = :facilityId and r.id = b.roomId
	AND b.id IN (SELECT bedId from lodging.bedLog WHERE eventEnd is NULL ) 
) x

    