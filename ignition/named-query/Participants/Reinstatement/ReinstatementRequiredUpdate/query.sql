UPDATE 
	participant.Suspension 
SET
	[participant].[Suspension].reinstateRequired  = 1
WHERE
	[participant].[Suspension].id IN (SELECT convert(int, value) FROM string_split(:IdList, ','))