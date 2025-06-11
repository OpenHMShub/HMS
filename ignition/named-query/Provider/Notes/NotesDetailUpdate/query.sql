UPDATE	organization.ProviderNotes
SET providerId = :provider_id,
	note = :note,
    timeCreated = :time_created,
    userName = :user_name 
WHERE id = :note_id;
