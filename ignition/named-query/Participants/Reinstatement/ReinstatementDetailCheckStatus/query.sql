SELECT
	 [participant].[Participant].suspensionActive as 'suspension_active'
FROM 
	[participant].[Participant]
WHERE
	[participant].[Participant].id =  :participant_id 