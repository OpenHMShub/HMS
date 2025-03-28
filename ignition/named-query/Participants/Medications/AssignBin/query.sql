INSERT INTO  
	participant.MedicationBinsLog 
	
(
	 location
	,bin
	,participantId
	,createdOn
	,startOn
	,shelterId
	,selectedMedications 
)
VALUES
(
	:location,
	:bin,
	:participantId,
	GETDATE(),
	:startOn,
	 :shelterId,
	  :selectedMedications 
)