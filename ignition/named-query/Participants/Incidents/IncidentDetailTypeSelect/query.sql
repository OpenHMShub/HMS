SELECT
	participant.IncidentType.Id   as 'incident_type_id',
	participant.IncidentType.incidentTypeName   as 'incident_type'

FROM
	[participant].[IncidentType]
	INNER JOIN [participant].[IncidentLogType] 
	ON [participant].[IncidentLogType] .IncidentTypeId = [participant].[IncidentType].id

WHERE
	
	[participant].[IncidentLogType].incidentLogId =  :incident_log_id
