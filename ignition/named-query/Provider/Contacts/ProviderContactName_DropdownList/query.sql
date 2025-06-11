SELECT
	organization.ProviderHuman_OV.[First Name] as 'contactName'
FROM
	organization.ProviderHuman_OV
WHERE 	
	organization.ProviderHuman_OV.organizationId = :provider_id 
ORDER BY [First Name]