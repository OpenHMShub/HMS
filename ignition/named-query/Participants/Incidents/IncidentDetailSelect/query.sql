---Participants/Incidents/IncidentDetailSelect---
SELECT
	[participant].[IncidentLog].id as 'id',
	--[participant].[IncidentLog].employeeId as 'employee_id', 
	--CONCAT(s_human.firstName,' ',s_human.middleName,' ',s_human.lastName) as 'employee_name',
	-- DATEADD(hh,12,CAST([participant].[IncidentLog].incidentDate as DATETIME)) as 'incident_date',
	[participant].[IncidentLog].incidentDate as 'incident_date',
	[participant].[IncidentLog].incidentName as 'incident_name',
	[participant].[IncidentLog].incidentLocationTypeID as 'incident_location_id',
	[participant].[IncidentLocationType].incidentLocationTypeName as 'incident_location_name',
	[participant].[IncidentLog].incidentDescription as 'incident_description',
	[participant].[IncidentLog].physicalInjury as 'physical_injury',
	[participant].[IncidentLog].propertyDamage as 'property_damage',
	[participant].[IncidentLog].barParticipant as 'bar_participant',
	[participant].[IncidentLog].timeCreated as 'time_created',
	[participant].[Participant].humanId as 'participant_human_id'


FROM
	
	[participant].[IncidentLog]
	--LEFT JOIN staff.Employee
	--ON [participant].[IncidentLog].employeeId = [staff].[Employee].Id
	--LEFT JOIN [humans].[Human] s_human
	--ON [staff].[Employee].humanId = s_human.id
	LEFT JOIN [participant].[Participant] 
	ON [participant].[IncidentLog].ParticipantID = [participant].[Participant].Id
	LEFT JOIN  [participant].[IncidentLocationType]
	ON  [participant].[IncidentLog].IncidentLocationTypeID = [participant].[IncidentLocationType].id
	
WHERE [participant].[IncidentLog].ParticipantID =  :participant_id 

ORDER BY incident_date DESC