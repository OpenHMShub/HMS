SELECT
	[interaction].[program].id AS 'program_id',
	[interaction].[program].programName AS 'program_name'
	
FROM
	[interaction].[program]
	INNER JOIN [interaction].[ProgramService]
	ON [interaction].[ProgramService].programId = [interaction].[program].id

WHERE 	
	[interaction].[ProgramService].serviceId =  :service_id 
ORDER BY program_name