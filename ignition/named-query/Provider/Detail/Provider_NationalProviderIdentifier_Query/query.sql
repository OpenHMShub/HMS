SELECT pt.providerTypeName
FROM organization.Provider p INNER JOIN organization.ProviderType pt on pt.id = p.providerTypeId
Where p.id =:trackID;