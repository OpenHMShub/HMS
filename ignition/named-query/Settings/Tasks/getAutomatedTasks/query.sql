SELECT *
FROM  
	participant.AutomatedTaskType 
WHERE 
	([isActive] = :isActive OR :isActive = -1)
	AND {search}
	