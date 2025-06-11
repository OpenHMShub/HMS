---Provider/Contacts/ContactsDetailSelect---
SELECT 
organization.ProviderContacts.id AS 'contactId', 
organization.ProviderContacts.firstName AS 'contactFirstName', 
organization.ProviderContacts.lastName AS 'contactLastName', 
organization.ProviderContacts.phone AS 'contactPhone',
organization.ProviderContacts.email AS 'contactEmail',   
organization.ProviderContacts.timeCreated AS 'timeCreated',
organization.ProviderContacts.notes AS 'notes'
FROM 
	organization.ProviderContacts
WHERE 	
	organization.ProviderContacts.providerId = :provider_id 
ORDER BY timeCreated DESC