---Participants/Reinstatement/SuspensionDetailSelect---

SELECT
	[participant].[Suspension].id as 'id',
	[participant].[Suspension].incidentLogID as 'incident_id',
	[participant].[IncidentLog].incidentDescription as 'incident_description',
	[participant].[Suspension].suspensionTypeId as 'suspension_type_id',
	[participant].[SuspensionType].suspensionTypeName as 'suspension_type_name',
	[participant].[Suspension].Duration as 'suspension_duration',
	[participant].[Suspension].timeBegin as 'suspension_time_begin',
	[participant].[Suspension].timeEnd as 'suspension_time_end',
	[participant].[Suspension].suspensionNotes as 'suspension_notes',
	[participant].[Suspension].timeCreated  as 'time_created',
	[participant].[Participant].suspensionActive as 'current_status'
FROM
	[participant].[Suspension]
	LEFT JOIN [participant].[SuspensionType]
	ON [participant].[Suspension].suspensionTypeID = [participant].[SuspensionType].id
	LEFT JOIN [participant].[IncidentLog]
	ON [participant].[Suspension].incidentLogID = [participant].[IncidentLog].id
	LEFT JOIN [participant].[Participant]
	ON [participant].[Suspension].participantId = [participant].[Participant].id
WHERE
	[participant].[Suspension].participantId =  :participant_id 
	AND {active}
