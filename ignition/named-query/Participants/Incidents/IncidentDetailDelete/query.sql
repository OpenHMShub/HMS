DELETE FROM
	 participant.IncidentAttendeeLog
WHERE
	 incidentLogId = :incident_row_id
DELETE FROM	
	participant.IncidentLog
WHERE 
	id = :incident_row_id