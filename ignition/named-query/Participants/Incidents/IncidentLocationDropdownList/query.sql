SELECT
	[participant].[IncidentLocationType].id as 'incident_location_id',
	[participant].[IncidentLocationType].incidentLocationTypeName as 'incident_location_name'
FROM
	[participant].[IncidentLocationType]

ORDER BY incident_location_name