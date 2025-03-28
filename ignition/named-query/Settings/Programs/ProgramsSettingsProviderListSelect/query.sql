SELECT
	[organization].[Provider].id,[organization].[Provider].providerName
FROM
	[organization].[Provider]
WHERE
	[organization].[Provider].timeRetired is Null
ORDER BY 
	[organization].[Provider].providerName