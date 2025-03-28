UPDATE 
	participant.Participant
SET
	[participant].[Participant].suspensionActive = 0
WHERE
	[participant].[Participant].id IN (SELECT convert(int, value) FROM string_split(:IdList, ','))