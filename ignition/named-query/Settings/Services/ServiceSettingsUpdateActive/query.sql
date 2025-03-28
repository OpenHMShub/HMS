UPDATE	interaction.Service 
SET	serviceName = :service_name,
 	serviceDescription = :service_desc,
	timeCreated = :time_created,
	allowUnder18 = :allowUnder18,
	timeRetired = Null
WHERE id = :service_id;