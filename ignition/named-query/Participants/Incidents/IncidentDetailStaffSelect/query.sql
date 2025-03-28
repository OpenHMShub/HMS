---Participants/Incidents/IncidentDetailStaffSelect---
SELECT
	[humans].[human].id as 'staff_involved_id',
	CONCAT([humans].[human].firstName,' ',[humans].[human].middleName,' ',[humans].[human].lastName) as 'staff_involved_name'

FROM
	[staff].[Employee]
	INNER JOIN [humans].[Human] 
	ON [staff].[Employee].humanId = [humans].[Human].id
	INNER JOIN [participant].[IncidentAttendeeLog] 
	ON [participant].[IncidentAttendeeLog].humanId = [humans].[Human].id

WHERE
	
	[participant].[IncidentAttendeeLog].incidentLogId =  :incident_log_id
	AND [participant].[IncidentAttendeeLog].incidentAttendeeTypeId = 3
