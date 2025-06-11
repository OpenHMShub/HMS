SELECT organization.Provider.id as 'ID',
  organization.Provider.organizationId as 'Organization ID',
  organization.Provider.providerName as 'Provider Name',
  organization.Provider.nationalProviderIdentifier as 'Provider',
  organization.Provider.regionServed as 'Region Served',
  organization.Provider.street as 'Address',
  organization.Provider.city as 'City',
  organization.Provider.state as 'State',
  organization.Provider.zipCode as 'Zip',
  organization.Provider.website as 'Website',
  organization.Provider.phone as 'Phone',
  organization.Provider.email as 'Email',
  organization.Provider.timeCreated as 'Entry Date'
FROM organization.Provider
WHERE organization.Provider.id =  :trackID 