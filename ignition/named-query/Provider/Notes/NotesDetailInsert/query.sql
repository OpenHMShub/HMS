INSERT INTO	organization.ProviderNotes
	(
	providerId,
	note, 
    timeCreated,
    userName 
	)
VALUES
	(
 	:provider_id,
    :note,
    :time_created,
    :user_name
	)