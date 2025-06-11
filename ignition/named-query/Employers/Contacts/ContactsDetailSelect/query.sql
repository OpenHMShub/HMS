---Employer/Contacts/ContactsDetailSelect---
SELECT 
organization.EmployerContacts.id AS 'contactId', 
organization.EmployerContacts.firstName AS 'contactFirstName', 
organization.EmployerContacts.lastName AS 'contactLastName', 
organization.EmployerContacts.phone AS 'contactPhone',
organization.EmployerContacts.email AS 'contactEmail',   
organization.EmployerContacts.timeCreated AS 'timeCreated'
FROM 
	organization.EmployerContacts
WHERE 	
	organization.EmployerContacts.employerId = :employer_id 
ORDER BY timeCreated DESC