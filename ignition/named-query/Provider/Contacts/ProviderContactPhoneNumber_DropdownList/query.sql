---Provider/Contacts/ProviderContactPhoneNumber_DropdownList---
SELECT
	organization.ProviderHuman_OV.[Phone Number] as 'contactPhone'
FROM
	organization.ProviderHuman_OV
WHERE 	
	organization.ProviderHuman_OV.organizationId = :provider_id
ORDER BY [Phone Number]