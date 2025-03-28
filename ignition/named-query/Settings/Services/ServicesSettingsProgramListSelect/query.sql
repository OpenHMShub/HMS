SELECT
	[interaction].[Program].id,[interaction].[Program].programName
FROM
	[interaction].[Program]
WHERE
	[interaction].[Program].timeRetired is Null
ORDER BY 
	[interaction].[Program].programName