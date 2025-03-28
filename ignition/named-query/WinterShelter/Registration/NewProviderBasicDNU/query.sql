INSERT INTO organization.Provider (
	street,
	providerName, 
	email, 
	state,
	timeCreated)
VALUES (
	:line1, 
	:congregation, 
	:email,
	:state,
	getDate());