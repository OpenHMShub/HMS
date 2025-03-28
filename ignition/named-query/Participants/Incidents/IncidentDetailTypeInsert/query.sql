INSERT INTO	participant.IncidentLogType
	(
	IncidentTypeId ,
	IncidentLogId,
    timeCreated
	)
VALUES
	(
	:type_id,
	:log_id,
	:time_created 
	)
