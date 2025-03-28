SELECT
	[humans].[Human].id
FROM
	[staff].[Employee]
	INNER JOIN [humans].[Human] on [staff].[Employee].humanId = [humans].[Human].id
	WHERE [humans].[Human].email is not null and [humans].[Human].email != '' AND [staff].[Employee].timeRetired is NULL
	AND REPLACE(CONCAT_WS(' ',[humans].[Human].firstName, [humans].[Human].middleName, [humans].[Human].lastName),'  ',' ') = REPLACE(:staff,'  ',' ')
	
	