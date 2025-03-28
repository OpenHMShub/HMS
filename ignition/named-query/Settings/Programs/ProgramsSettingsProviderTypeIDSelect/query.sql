SELECT
	[interaction].[ProgramProviderTypes].providerTypeId AS 'typeId'
	--[organization].[ProviderType].providerTypeName  AS 'typeName'
	
FROM
	[interaction].[ProgramProviderTypes]
	--INNER JOIN [organization].[ProviderType]
	--ON [interaction].[ProgramProviderTypes].providerTypeId = [organization].[ProviderType].id

WHERE 	
	[interaction].[ProgramProviderTypes].programId  =  :programId 
ORDER BY typeId