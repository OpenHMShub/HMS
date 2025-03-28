UPDATE	interaction.Service 
SET	serviceName = :service_name,
 	serviceDescription = :service_desc,
	timeCreated = :time_created,
	timeRetired = :time_retired,
	allowUnder18 = :allowUnder18
WHERE id = :service_id;