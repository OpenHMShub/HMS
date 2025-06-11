SELECT DISTINCT
	 [participant].[IncidentAttendeeLog].incidentAttendeeTypeId as 'participant_role_id',
	 [participant].[IncidentAttendeeType]. incidentAttendeeTypeName as 'participant_role'

FROM
	
	[participant].[IncidentAttendeeLog]
	INNER JOIN [participant].[IncidentAttendeeType]
	ON [participant].[IncidentAttendeeLog].incidentAttendeeTypeId = [participant].[IncidentAttendeeType].id

WHERE
	
	[participant].[IncidentAttendeeLog].incidentLogId =  :incident_log_id 
