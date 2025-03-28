UPDATE
	participant.MedicationBinsLog 
SET
	createdOn = GETDATE(),
	startOn = :startOn,
	location = :location,
	bin = :bin, 
	selectedMedications = :selectedMedications
WHERE
	id = :id