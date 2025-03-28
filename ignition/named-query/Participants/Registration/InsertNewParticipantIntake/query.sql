Insert into [participant].IntakeLog (
	formLogId,
	intakeDate,
	intakeTypeId,
	timeCreated,
	userName
) 
VALUES (
	:form_log_id,
	GetDate(),
	:intake_type_id,
	GetDate(),
	:user_name
)
