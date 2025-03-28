---Participants/DrugScreen/ProviderListSelect---
SELECT
	id,providerName
FROM
	organization.Provider
WHERE
	[organization].[Provider].providerTypeId =  :provider_type_id 
ORDER BY providerName