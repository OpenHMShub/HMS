SELECT
	[interaction].[Program].id, [interaction].[Program].programName as 'program_name'
FROM
	[participant].[Enrollments]
INNER JOIN 
	[interaction].[Program] ON [participant].[Enrollments].programId=[interaction].[Program].id
WHERE 
	[participant].[Enrollments].particpantId =:participantId
ORDER BY 
	program_name
