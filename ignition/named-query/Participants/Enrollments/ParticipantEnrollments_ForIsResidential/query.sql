SELECT 
	[participant].[Enrollments].id, 
	[interaction].[Program].programName
FROM 
	[participant].[Enrollments]
INNER JOIN 
	[interaction].[Program] 
ON 
	[participant].[Enrollments].programId=[interaction].[Program].id
WHERE 
	particpantId =:participantId
AND 
	[interaction].[Program].isResidential = 'True'
ORDER BY 
	programName