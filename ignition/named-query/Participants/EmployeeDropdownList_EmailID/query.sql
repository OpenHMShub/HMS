---Participants/EmployeeDropdownList---
SELECT
	[humans].[Human].email as 'value',
	CONCAT_WS(' ',[humans].[Human].firstName, [humans].[Human].middleName, [humans].[Human].lastName) as 'label'
FROM
	[staff].[Employee]
	INNER JOIN [humans].[Human] on [staff].[Employee].humanId = [humans].[Human].id
	WHERE [humans].[Human].email is not NULL AND [humans].[Human].email != ''