INSERT INTO	participant.IncidentAttendeeLog
	(
	humanId,
	incidentAttendeeTypeId,
	incidentLogId,
    timeCreated
	)
VALUES
	(
	:human_id,
	:type_id,
	:log_id,
	:time_created 
	)
