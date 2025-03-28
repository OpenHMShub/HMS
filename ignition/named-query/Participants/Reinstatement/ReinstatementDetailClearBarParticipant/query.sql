UPDATE
	participant.IncidentLog
SET  
	[participant].[IncidentLog].barParticipant = 0
WHERE
	[participant].[IncidentLog].id = :incident_id 