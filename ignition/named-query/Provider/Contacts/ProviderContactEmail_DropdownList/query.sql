SELECT
	organization.ProviderHuman_OV.email as 'contactEmail'
FROM
	organization.ProviderHuman_OV
WHERE 	
	organization.ProviderHuman_OV.organizationId = :provider_id
ORDER BY email DESC