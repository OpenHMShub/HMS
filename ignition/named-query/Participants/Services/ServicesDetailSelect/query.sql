---Participants/Services/ServicesDetailSelect---
SELECT
	[participant].[services].id AS 'row_id',
	[participant].[services].employeeId AS 'employee_id',
	CONCAT([humans].[Human].firstName,' ',[humans].[Human].middleName,' ',[humans].[Human].lastName) as 'employee_name',
	[participant].[services].programid AS 'enrollment_id',
	[interaction].[program].programName AS 'enrollment_name',
	[interaction].[service].ServiceTypeid  as 'type_id',
	[participant].[services].Serviceid  as 'service_id',
	[interaction].[service].serviceName AS 'service_name',
	[participant].[services].timeCreated AS 'time_created',
	[participant].[services].HMIS  AS 'HMIS',
	[participant].[services].quantity  AS 'quantity',
	[participant].[services].comment AS 'comment',
	( SELECT [participant].[CaseNotesServices].CaseNotesId 
	FROM
	[participant].[CaseNotesServices]
	WHERE
	[participant].[CaseNotesServices].ServicesId = [participant].[services].id
	) as 'note_id',
	[participant].[services].ServiceLocationId as 'service_location_id',
	COALESCE([interaction].[ServiceLocation].location, '') as 'serviceLocation'


FROM
	[participant].[services]
	LEFT JOIN [interaction].[program]
	ON [participant].[services].programid = [interaction].[program].id
	LEFT JOIN [interaction].[service]
	ON [participant].[services].Serviceid = [interaction].[service].id
	LEFT JOIN [interaction].[ServiceLocation] 
	ON [participant].[services].ServiceLocationId = [interaction].[ServiceLocation].id

	LEFT JOIN staff.Employee
	ON [participant].[services].employeeId = [staff].[Employee].Id
	LEFT JOIN [humans].[Human] 
	ON [staff].[Employee].humanId = [humans].[Human].id
WHERE 	
	[participant].[services]. participantId =  :participant_id
ORDER BY time_created DESC