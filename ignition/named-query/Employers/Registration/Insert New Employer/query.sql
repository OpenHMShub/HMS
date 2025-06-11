
Insert into organization.EmployerNew ([Employer Name],
	[Business Description],
	Qualifiers,
	Status,
	street,
	city,
	state,
	zipCode,
	phone,
	email,
	website,
	timeCreated
)
Values (:orgName,
	:businessDesc,
	:qualifiers,
	:status,
	:addr,
	:city,
	:state,
	:zip,
	:phone,
	:email,
	:website,
	GetDate()
)