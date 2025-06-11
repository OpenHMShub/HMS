---Participants/Incidents/IncidentDetailSelect---
SELECT
	[participant].[IncidentLog].incidentDate as 'incident_date'
, MONTH([participant].[IncidentLog].incidentDate) as 'incident_month'

FROM [participant].[IncidentLog]
	
WHERE [participant].[IncidentLog].ParticipantID =  :participant_id

ORDER BY incident_date ASC