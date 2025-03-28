---Participants/ServiceDropdownListAll
SELECT
	[interaction].[Service].id,[interaction].[Service].serviceName as 'service_name'
FROM
	[interaction].[Service]
WHERE 
	timeRetired IS NULL
ORDER BY service_name