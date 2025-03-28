SELECT * FROM (
	SELECT shelter.Tasks.id, shelter.Tasks.dueDate, shelter.Tasks.locationId,shelter.Tasks.notes,
		shelter.Tasks.staffId,shelter.Tasks.statusId, shelter.Tasks.taskTypeId, shelter.Tasks.timeCreated,
		shelter.Tasks.completedDate as completed, shelter.Tasks.title, COALESCE(shelter.Tasks.contact,'') as contact, 
	  	shelter.Location.locationName,
	  	ISNULL((select type from shelter.taskType where id = shelter.Tasks.taskTypeId),'') as type,
	  	ISNULL((select Status from shelter.Status where id = shelter.Tasks.statusId),'') as Status,
	  	ISNULL((select priority from shelter.Priority where id = shelter.Tasks.priority),'') as taskPriority,
	  	shelter.Tasks.priority as priorityId,
	  	CONCAT(humans.Human.firstName, ' ', humans.Human.lastName) as staffName,
	  	shelter.Tasks.assignerId, shelter.Tasks.participantId,
	  	(select CONCAT(h.firstName, ' ',h.lastName) from humans.Human h where h.id = shelter.Tasks.assignerId) as assigner
	  	FROM shelter.Tasks
	  	INNER JOIN shelter.Location ON shelter.Location.id =  shelter.Tasks.locationId
	  	INNER JOIN humans.Human ON shelter.Tasks.staffId = humans.Human.id
	  	WHERE shelter.Tasks.timeRetired is NULL AND shelter.Tasks.dueDate >= :startDateFilter
	  	AND (:loggedInStaffId IS NULL OR :loggedInStaffId = '' OR (shelter.Tasks.staffId = :loggedInStaffId) OR (shelter.Tasks.assignerId = :loggedInStaffId))
	  	AND (:statusId IS NULL OR :statusId = -1 OR (shelter.Tasks.statusId = :statusId))
	  	AND (:congregationId IS NULL OR :congregationId = -1 OR (shelter.Tasks.locationId = :congregationId))
	  	AND (:priorityId IS NULL OR :priorityId = -1 OR (shelter.Tasks.priority = :priorityId))
	  	AND (
	  		(:activeInactive IS NULL OR :activeInactive = '' OR :activeInactive = 'Active & Inactive') OR
	  		(:activeInactive = 'Active' AND shelter.Tasks.completedDate IS NULL) OR
	  		(:activeInactive = 'Inactive' AND shelter.Tasks.completedDate IS NOT NULL) 
	  		)
	  	AND( :dateRangeStart IS NULL OR :dateRangeStart = '' OR (shelter.Tasks.dueDate >= :dateRangeStart))
	  	AND( :dateRangeEnd IS NULL OR :dateRangeEnd = '' OR (shelter.Tasks.dueDate <= :dateRangeEnd))
	  	AND (:searchText IS NULL OR 
	  	     :searchText = '' OR 
	  	     shelter.Location.locationName LIKE :searchText OR 
	  	     humans.Human.firstName LIKE :searchText OR 
	  	     humans.Human.lastName LIKE :searchText OR
	  	     ISNULL((select type from shelter.taskType where id = shelter.Tasks.taskTypeId),'') LIKE :searchText OR
	  	     ISNULL((select Status from shelter.Status where id = shelter.Tasks.statusId),'') LIKE :searchText OR
	  	     shelter.Tasks.title LIKE :searchText OR
	  	     shelter.Tasks.contact LIKE :searchText OR
	  	     ISNULL((select priority from shelter.Priority where id = shelter.Tasks.priority),'') LIKE :searchText
	  	     )
	) taskTable
WHERE (:staffId IS NULL OR :staffId = -1 OR (taskTable.staffId = :staffId))