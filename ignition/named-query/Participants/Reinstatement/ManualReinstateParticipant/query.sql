UPDATE 
	participant.Participant
SET
	[participant].[Participant].suspensionActive = 0
WHERE
	[participant].[Participant].id = :participantId 