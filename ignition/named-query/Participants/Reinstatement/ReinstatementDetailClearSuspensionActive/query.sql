UPDATE
	participant.Participant 
SET  
	[participant].[Participant].suspensionActive = NULL
WHERE
	[participant].[Participant].id = :participant_id 