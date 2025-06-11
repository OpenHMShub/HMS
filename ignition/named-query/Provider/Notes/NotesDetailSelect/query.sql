SELECT
	organization.ProviderNotes.id AS 'id',
	organization.ProviderNotes.providerId AS 'provider_id',
	organization.ProviderNotes.note as 'note',
	organization.ProviderNotes.timeCreated AS 'time_created'
FROM
	organization.ProviderNotes
WHERE 	
	organization.ProviderNotes.providerId = :provider_id	 
ORDER BY time_created DESC