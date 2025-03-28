---Participants/EmployeeHumanDropdownList---
SELECT
	[staff].[Employee].humanId,
	CONCAT_WS(' ',[humans].[Human].firstName, [humans].[Human].middleName, [humans].[Human].lastName) as 'employee_name'
FROM
	[staff].[Employee]
	INNER JOIN [humans].[Human] on [staff].[Employee].humanId = [humans].[Human].id
WHERE
	[staff].[Employee].id > 0 AND 
	[staff].[Employee].timeRetired is NULL 
	AND  [humans].[Human].email is not NULL
	AND [humans].[Human].email != ''
	ORDER BY [humans].[Human].firstName