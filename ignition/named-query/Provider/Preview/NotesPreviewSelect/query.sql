Declare @provider_id as int =  :provider_id ;

SELECT TOP 1
	organization.ProviderNotes.note as note,
	organization.ProviderNotes.userName as 'user',
	CONVERT(VARCHAR(10), organization.ProviderNotes.timeCreated, 101) as Date,
  	CONVERT(VARCHAR(10), CAST(organization.ProviderNotes.timeCreated AS TIME), 108) as Time
FROM
	organization.ProviderNotes
WHERE 	
	organization.ProviderNotes.providerId =  @provider_id 
ORDER BY organization.ProviderNotes.timeCreated DESC
