SELECT
	id
	,programName
FROM
	[interaction].[Program]
WHERE
 	timeRetired IS NULL
 	
GROUP BY id
		,programName
ORDER BY programName