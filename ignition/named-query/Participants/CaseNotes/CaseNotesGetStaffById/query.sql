SELECT
	CONCAT_WS(' ',[humans].[Human].firstName, [humans].[Human].middleName, [humans].[Human].lastName) as 'employee_name',
	[humans].[Human].email as 'employee_email'
FROM 
	[staff].[Employee]
INNER JOIN 
	[humans].[Human] on [staff].[Employee].humanId = [humans].[Human].id
WHERE 
	[staff].[Employee].timeRetired is NULL AND  [humans].[Human].email is not NULL AND [humans].[Human].email != ''
	AND [staff].[Employee].id = :staffId