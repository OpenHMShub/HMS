---Participants/ProgramDropdownList---
SELECT
	DISTINCT [interaction].[Program].id, [interaction].[Program].programName as 'program_name'
FROM
	[interaction].[Program]
Where timeRetired IS NULL
ORDER BY program_name