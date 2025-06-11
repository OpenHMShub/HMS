SELECT
	 [shelter].[WaitListPrograms].ID as 'id'
FROM
	[shelter].[WaitListPrograms]
WHERE
	[shelter].[WaitListPrograms].programId  =  :program_id 