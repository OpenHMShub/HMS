INSERT INTO	interaction.Service 
	(
 	serviceName,
 	ctid, 
 	serviceTypeId,
 	timeCreated,
 	timeRetired 
	)
VALUES
	( 
	:service_name,
	:ctid, 
	0,
	GetDate(),
	GetDate()
	)