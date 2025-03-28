SELECT
	[interaction].[ProgramProviderTypes].providerTypeId AS 'typeId'
	
FROM
	[interaction].[ProgramProviderTypes]

WHERE 	
	[interaction].[ProgramProviderTypes].programId  =  :programId 