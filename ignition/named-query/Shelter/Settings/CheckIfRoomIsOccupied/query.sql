SELECT COUNT(x.id)
FROM
(
	SELECT id 
	FROM lodging.Bed 
	WHERE roomId = :roomId 
	AND id IN (SELECT bedId from lodging.bedLog WHERE eventEnd is NULL ) 
) x

    