---Participants/ProgramDropdownList---
SELECT
	DISTINCT [interaction].[Program].id, [interaction].[Program].programName as 'program_name'
FROM
	[interaction].[Program]
	INNER JOIN [participant].[Enrollments]
	ON [participant].[Enrollments].programId =  [interaction].[Program].id
WHERE
		[participant].[Enrollments].particpantId  =  :participant_id 
ORDER BY program_name