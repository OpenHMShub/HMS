UPDATE 
	participant.Suspension
SET
	dateReinstated = GetDate()
WHERE
	participant.Suspension.participantId = :participantId 
	AND
	participant.Suspension.id =  :suspensionId 