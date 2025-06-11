SELECT
	[participant].[IncidentType].id as 'incident_type_id',
	[participant].[IncidentType].incidentTypeName as 'incident_type_name'
FROM
	[participant].[IncidentType]

ORDER BY incident_type_name