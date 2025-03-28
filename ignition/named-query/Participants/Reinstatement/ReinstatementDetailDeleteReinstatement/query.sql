DELETE FROM
	participant.ReinstatementLog 
WHERE
	[participant].[ReinstatementLog].suspensionId = :suspension_id 