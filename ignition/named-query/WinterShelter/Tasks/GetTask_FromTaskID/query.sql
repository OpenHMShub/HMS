SELECT shelter.Tasks.id, shelter.Tasks.dueDate, shelter.Tasks.locationId,shelter.Tasks.notes,
	shelter.Tasks.staffId,shelter.Tasks.statusId, shelter.Tasks.taskTypeId, shelter.Tasks.timeCreated,
	shelter.Tasks.completedDate as completed, shelter.Tasks.title, COALESCE(shelter.Tasks.contact,'') as contact, 
  	shelter.Location.locationName,
  	shelter.taskType.type,
  	shelter.Status.Status,
  	shelter.Priority.priority as taskPriority,
  	shelter.Tasks.priority as priorityId,
  	CONCAT(humans.Human.firstName, ' ', humans.Human.lastName) as staffName,
  	shelter.Tasks.assignerId, shelter.Tasks.participantId,
  	(select CONCAT(h.firstName, ' ',h.lastName) from humans.Human h where h.id = shelter.Tasks.assignerId) as assigner
  	FROM shelter.Tasks
  	INNER JOIN shelter.Location ON shelter.Location.id =  shelter.Tasks.locationId
  	INNER JOIN shelter.taskType ON shelter.Tasks.taskTypeId = shelter.taskType.id
  	INNER JOIN shelter.Status ON shelter.Tasks.statusId = shelter.Status.id
  	INNER JOIN shelter.Priority ON shelter.Tasks.priority = shelter.Priority.id
  	INNER JOIN humans.Human ON shelter.Tasks.staffId = humans.Human.id
  	WHERE shelter.Tasks.timeRetired is NULL 
  	AND shelter.Tasks.id = :taskId