UPDATE
	participant.Participant 
SET  
	[participant].[Participant].suspensionActive = 1
WHERE
	[participant].[Participant].id = :participant_id 