---Participants/CaseNotes/CaseNotesServiceSelect---
SELECT
	[participant].[services].id AS 'servicesRowId',
	[participant].[services]. participantId,
	[participant].[CaseNotesServices].CaseNotesId,
	[participant].[services].employeeId AS 'employeeId',
	CONCAT_WS(' ',[humans].[Human].firstName,[humans].[Human].middleName,[humans].[Human].lastName) as 'employeeName',
	[participant].[services].programid AS 'programId',
	[interaction].[program].programName AS 'programName',
	[interaction].[service].serviceTypeId AS 'serviceTypeId',
	[participant].[services].Serviceid  as 'serviceId',
	[interaction].[service].serviceName AS 'serviceName',
	[participant].[services].timeCreated,
	IIF([participant].[services].HMIS = 1,1,0) AS 'HMIS',
	[participant].[services].quantity  AS 'quantity',
	[participant].[services].comment AS 'comment',
	 [participant].[services].ServiceLocationId AS 'service_location_id'
FROM
	[participant].[services]
	LEFT JOIN [interaction].[program]
	ON [participant].[services].programid = [interaction].[program].id
	LEFT JOIN [interaction].[service]
	ON [participant].[services].Serviceid = [interaction].[service].id
	LEFT JOIN staff.Employee
	ON [participant].[services].employeeId = [staff].[Employee].Id
	LEFT JOIN [humans].[Human] 
	ON [staff].[Employee].humanId = [humans].[Human].id
	LEFT JOIN  [participant].[CaseNotesServices]
	ON [participant].[CaseNotesServices].ServicesId = [participant].[services].id
WHERE 	
	[participant].[services]. participantId =  :participant_id
	AND [participant].[CaseNotesServices].CaseNotesId =  :case_note_id 
	AND {program}
	AND {service}
ORDER BY timeCreated