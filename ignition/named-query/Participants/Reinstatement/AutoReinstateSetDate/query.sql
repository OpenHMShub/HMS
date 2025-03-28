UPDATE 
	participant.Suspension
SET
	dateReinstated = GetDate()
WHERE
	participant.Suspension.participantId IN (SELECT convert(int, value) FROM string_split(:IdList, ','))