---Participants/CaseManagerDropdownList---
SELECT
	[participant].[CaseManager].id,
	CONCAT_WS(' ',[humans].[Human].firstName, [humans].[Human].middleName, [humans].[Human].lastName) as 'employee_name'
FROM
	[participant].[CaseManager]
	INNER JOIN [staff].[Employee] ON [participant].[CaseManager].EmployeeId = [staff].[Employee].id
	INNER JOIN [humans].[Human] on [staff].[Employee].humanId = [humans].[Human] .id