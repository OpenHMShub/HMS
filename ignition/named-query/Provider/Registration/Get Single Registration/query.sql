Select 
	organization.Provider.id,
  	organization.Provider.organizationId,
	organization.Provider.providerName,
	organization.Provider.locationDescription,
  	organization.Provider.nationalProviderIdentifier as providerType,
  	organization.Provider.regionServed,
	organization.Provider.street,
  	organization.Provider.city,
  	organization.Provider.state,
  	organization.Provider.zipCode,
  	organization.Provider.website,
  	organization.Provider.phone,
  	organization.Provider.email,
  	organization.Provider.contactName,
  	organization.Provider.contactPhone,
  	organization.Provider.timeCreated
 
from organization.Provider

Where organization.Provider.organizationId = :provID