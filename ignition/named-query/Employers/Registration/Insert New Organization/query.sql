Insert into organization.Organization (orgName,
	timeCreated
)
Values (:orgName,
		GetDate()
)