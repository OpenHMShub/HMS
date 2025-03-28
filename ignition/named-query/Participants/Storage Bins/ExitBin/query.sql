UPDATE
	participant.StorageBinsLog
SET 
	exitAction = :exitAction,
	exitedOn = :exitedOn,
	exitedByStaffEmployeeId = :staffEmployeeId

WHERE
	id = :id	