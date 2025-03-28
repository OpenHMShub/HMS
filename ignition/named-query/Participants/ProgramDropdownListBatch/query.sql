---Participants/ProgramDropdownListBatch---
SELECT
	[interaction].[Program].id,[interaction].[Program].programName as 'program_name'
FROM
	[interaction].[Program]
WHERE timeRetired IS NULL
ORDER BY program_name