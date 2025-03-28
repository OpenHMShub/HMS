Insert into [participant].Participant (
	humanId,
	caseManagerId,
	intakeLogId,
	timeCreated,
	timeRegistered,
	suspensionActive 
) 
VALUES (
	:human_id,
	NULL,
	NULL,
	GetDate(),
	GetDate(),
	0
)
