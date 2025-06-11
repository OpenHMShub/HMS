Update [organization].EmployerNew
Set 
	[Employer Name] = :orgName,
	street = :addr,
	city = :city,
	state = :state,
	zipCode = :zip,
	phone = :phone,
	email = :email,
	website = :website,
	[Business Description] = :businessDesc,
	Qualifiers = :qualifiers,
	Status = :status
	
	

Where id = :orgId