Update [organization].Provider
Set 
	providerName = :providerName,
	providerTypeId= :providerTypeId,
	street = :street,
	city = :city,
	state = :state,
	zipCode = :zip,
	phone = :phone,
	email = :email,
	website = :website,
	nationalProviderIdentifier = :nationalProvID,
	locationDescription = :locationDesc,
	contactName = :contactName,
	contactPhone = :contactPhone

Where organizationId = :provId