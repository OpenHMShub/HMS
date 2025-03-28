UPDATE	
	[participant].[AutomatedTaskType]
SET
	[isActive] = :isActive,
	[type] = :taskType,
	[description] = :taskDesc
WHERE
	[id] = :taskId