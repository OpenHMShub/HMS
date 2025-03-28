---Participants/EmployeeDropdownList---
SELECT
	[staff].[Employee].id
FROM
	[staff].[Employee]
	INNER JOIN [humans].[Human] on [staff].[Employee].humanId = [humans].[Human].id
	WHERE :emailID != '' AND [humans].[Human].email = :emailID