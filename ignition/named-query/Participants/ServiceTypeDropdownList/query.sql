---Participants/ServiceTypeDropdownList---
SELECT DISTINCT
	[interaction].[ServiceType].id, [interaction].[ServiceType].serviceTypeName as 'service_type'
FROM
	[interaction].[Service]
	INNER JOIN [interaction].[ProgramService]
	ON [interaction].[ProgramService].serviceId = [interaction].[Service].id
	LEFT JOIN [interaction].[ServiceType]
	ON [interaction].[ServiceType].id = [interaction].[Service].serviceTypeId
WHERE
	[interaction].[ProgramService].programId =  :program_id
ORDER BY service_type