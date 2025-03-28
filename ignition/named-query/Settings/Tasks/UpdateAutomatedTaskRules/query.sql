UPDATE
	[participant].[AutomatedTaskRules]
SET
	[entryCriteriaTime] = :entryCriteriaTime, 
	[entryCriteriaTimeUnits] = :entryCriteriaTimeUnits,
	[taskDueDateTime] = :taskDueDateTime,
	[taskDueDateTimeUnints] = :taskDueDateTimeUnints, 
	[taskSubject] = :taskSubject, 
	[taskPriority] = :taskPriority,
	[taskNotes] = :taskNotes,
	[taskType] = :taskType
WHERE
	[id] = :ruleId