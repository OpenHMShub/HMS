SELECT
	COUNT(id) 
FROM
	[participant].[Suspension]
WHERE
	[participant].[Suspension].participantId =  :participantId 
	AND
	[participant].[Suspension].dateReinstated  is Null