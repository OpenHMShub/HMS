---Employer/Contacts/ContactsDetailSelect---
SELECT 
organization.VendorContacts.id AS 'contactId', 
organization.VendorContacts.firstName AS 'contactFirstName', 
organization.VendorContacts.lastName AS 'contactLastName', 
organization.VendorContacts.phone AS 'contactPhone',
organization.VendorContacts.email AS 'contactEmail',   
organization.VendorContacts.timeCreated AS 'timeCreated'
FROM 
	organization.VendorContacts
WHERE 	
	organization.VendorContacts.vendorId = :vendor_id 
ORDER BY timeCreated DESC