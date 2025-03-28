SELECT id as 'value' , providerName as 'label'
FROM organization.provider
WHERE providerTypeId = :typeId and timeRetired is null
--AND id IN (SELECT providerId FROM organization.Congregation WHERE timeRetired IS NULL)
AND ((id IN (SELECT providerId FROM organization.Congregation WHERE timeRetired IS NULL) AND providerTypeId = 8) OR
(id IN (SELECT id FROM organization.provider WHERE timeRetired IS NULL) AND providerTypeId != 8))
order by providerName