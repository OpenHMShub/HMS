SELECT op.*
FROM 
	participant.StorageBinsYOptions op
WHERE op.timeRetired IS NULL and op.yValue NOT IN 
	(
	SELECT bin FROM participant.StorageBinsLog
	WHERE exitedOn IS NULL and cancelledOn IS NULL
		AND col = :xValue
	)