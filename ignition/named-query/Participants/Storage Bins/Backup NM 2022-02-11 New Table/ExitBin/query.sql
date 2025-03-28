UPDATE
	participant.StorageBinsLog
SET 
	exitAction = :exitAction,
	exitedOn = :exitedOn,
	exitedByStaffEmployeeId = :employeeId

WHERE
	id = :id