UPDATE
	lodging.BedLog
SET
	eventStart = :eventStart,
	eventEnd = :eventEnd,
	exitDestinationId = :exitDestinationId
WHERE
	id = :bedLogId
