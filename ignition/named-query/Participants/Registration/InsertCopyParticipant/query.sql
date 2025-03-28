Insert into [participant].Participant (
	humanId,
	caseManagerId,
	intakeLogId,
	timeCreated,
	suspensionActive 
) 
VALUES (
	:human_id,
	NULL,
	NULL,
	GetDate(),
	0
)
