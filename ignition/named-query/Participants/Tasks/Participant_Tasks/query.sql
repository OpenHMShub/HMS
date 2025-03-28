SELECT participant.Tasks.id, participant.Tasks.dueDate, participant.Tasks.participantId,participant.Tasks.notes,
	participant.Tasks.staffId,participant.Tasks.assignerId,participant.Tasks.statusId, participant.Tasks.taskTypeId, participant.Tasks.timeCreated,
	participant.Tasks.completedDate as completed, participant.Tasks.title ,
  	(select CONCAT(firstName, ' ', middleName, ' ', lastName) from participant.Dashboard where id = participant.Tasks.participantId) as participantName,
  	(select type from shelter.taskType where id = participant.Tasks.taskTypeId) as type,
  	(select Status from shelter.Status where id =  participant.Tasks.statusId) as Status,
  	(select priority from shelter.Priority where id = participant.Tasks.priority) as taskPriority,
  	participant.Tasks.priority as priorityId,
  	CONCAT(humans.Human.firstName, ' ', humans.Human.lastName) as staffName,
  	CONCAT(assHuman.firstName, ' ', assHuman.lastName) as assignerName
  	FROM participant.Tasks
  	INNER JOIN [staff].[Employee] ON participant.Tasks.staffId = [staff].[Employee].id
  	INNER JOIN [staff].[Employee] ass ON participant.Tasks.assignerId = ass.id
  	INNER JOIN humans.Human ON [staff].[Employee].humanId = humans.Human.id
  	INNER JOIN humans.Human assHuman ON ass.humanId = assHuman.id
  	WHERE participant.Tasks.timeRetired is NULL AND participant.Tasks.dueDate >= :startDateFilter
  	AND (:staffId IS NULL OR :staffId = -1 OR (participant.Tasks.staffId = :staffId))
  	AND (:assignerId IS NULL OR :assignerId = -1 OR (participant.Tasks.assignerId = :assignerId))
  	AND (:statusId IS NULL OR :statusId = -1 OR (participant.Tasks.statusId = :statusId))
  	AND (:priorityId IS NULL OR :priorityId = -1 OR (participant.Tasks.priority = :priorityId))
  	AND (
  		(:activeInactive IS NULL OR :activeInactive = '' OR :activeInactive = 'Active & Inactive') OR
  		(:activeInactive = 'Active' AND participant.Tasks.completedDate IS NULL) OR
  		(:activeInactive = 'Inactive' AND participant.Tasks.completedDate IS NOT NULL) 
  		)
  	AND( :dateRangeStart IS NULL OR :dateRangeStart = '' OR (participant.Tasks.dueDate >= :dateRangeStart))
  	AND( :dateRangeEnd IS NULL OR :dateRangeEnd = '' OR (participant.Tasks.dueDate <= :dateRangeEnd))
  	AND (:searchText IS NULL OR 
  	     :searchText = '' OR 
  	     (select CONCAT(firstName, ' ', middleName, ' ', lastName) from participant.Dashboard where id = participant.Tasks.participantId) LIKE :searchText OR 
  	     humans.Human.firstName LIKE :searchText OR 
  	     humans.Human.lastName LIKE :searchText OR
  	     assHuman.firstName LIKE :searchText OR 
  	     assHuman.lastName LIKE :searchText OR
  	     (select type from shelter.taskType where id = participant.Tasks.taskTypeId) LIKE :searchText OR
  	     (select Status from shelter.Status where id =  participant.Tasks.statusId) LIKE :searchText OR
  	     participant.Tasks.title LIKE :searchText OR
  	     (select priority from shelter.Priority where id = participant.Tasks.priority) LIKE :searchText
  	     )
order by participant.Tasks.timeCreated desc