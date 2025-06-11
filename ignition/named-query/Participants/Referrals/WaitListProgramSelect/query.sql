SELECT
	 [shelter].[WaitListPrograms].id as 'id', 
	 [interaction].[program].programName as 'program_name'
FROM
	[shelter].[WaitListPrograms]
	INNER JOIN [interaction].[program] ON [shelter].[WaitListPrograms].programId = [interaction].[program].id