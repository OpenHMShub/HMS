SELECT
	[organization].[ProviderType].id AS 'typeId',
	[organization].[ProviderType].providerTypeName  AS 'typeName'
	
FROM
	[organization].[ProviderType]

ORDER BY typeName