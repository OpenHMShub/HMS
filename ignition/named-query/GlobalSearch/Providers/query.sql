SELECT organization.Provider.id as 'ID',
  organization.Provider.providerName as 'ProviderName',
  organization.Provider.nationalProviderIdentifier as 'NationalProvider',
  organization.Provider.regionServed as 'RegionServed',
  organization.Provider.street as 'Address',
  organization.Provider.city as 'City',
  organization.Provider.state as 'State',
  organization.Provider.zipCode as 'Zip',
  organization.Provider.website as 'Website',
  organization.Provider.phone as 'Phone',
  organization.Provider.email as 'Email',
  organization.Provider.timeCreated as 'EntryDate'
FROM organization.Provider