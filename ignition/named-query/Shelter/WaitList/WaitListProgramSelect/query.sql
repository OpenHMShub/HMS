SELECT
	 [interaction].[program].id as 'id'
FROM
	[shelter].[WaitListPrograms]
	INNER JOIN [interaction].[program] ON [shelter].[WaitListPrograms].programId = [interaction].[program].id