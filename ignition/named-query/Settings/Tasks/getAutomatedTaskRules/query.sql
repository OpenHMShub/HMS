SELECT 
		[id]
      ,[automatedTaskId]
      ,[RuleNumber]
      ,[entryCriterialLabel]
      ,[entryCriteriaTime]
      ,[entryCriteriaTimeUnits]
      ,[taskDueDateTime]
      ,[taskDueDateTimeUnints]
      ,[taskSubject]
      ,[taskType]
      ,(SELECT shelter.taskType.type from shelter.taskType where timeRetired IS NULL and shelter.taskType.id = [taskType]) as 'taskTypeName'
      ,ISNULL([taskNotes],'') as 'taskNotes'
      ,[timeCreated]
      ,[timeRetired]
      ,[taskPriority]
      ,(select Priority from shelter.Priority where id=taskPriority) as 'taskPriorityName'
FROM  
	participant.AutomatedTaskRules 
WHERE  
	automatedTaskId =  :taskId 