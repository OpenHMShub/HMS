---Participants/DrugScreen/ProviderListSelect--- --[organization].[Provider].providerTypeId NOT IN (1,4,8)
SELECT
	id,providerName
FROM
	organization.Provider
WHERE
	[organization].[Provider].providerTypeId IN {providerTypeIdList}
ORDER BY providerName