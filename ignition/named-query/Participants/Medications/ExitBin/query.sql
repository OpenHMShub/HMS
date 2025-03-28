IF :exitAction = 1 
BEGIN
	UPDATE participant.MedicationBinsLog 
	SET exitAction = :exitAction, exitedOn = :exitedOn,  exitedByStaffEmployeeId = :staffEmployeeId
	WHERE id = :id	
END
ELSE 
BEGIN
UPDATE participant.MedicationBinsLog 
	SET exitAction = :exitAction, disposedOn = :exitedOn,  disposedByStaffEmployeeId = :staffEmployeeId
	WHERE id = :id	
END