Insert into organization.ProviderHuman_OV (
	providerId,
	providerHumanId,
	[First Name],
	[Last Name],
	[Phone Number],
	email,
	providerHumanTimeCreated
)
Values (
	:providerId,
	:contactId,
	:contactName,
	:contactLastName,
	:contactPhone,
	:contactEmail,
	GetDate()
)