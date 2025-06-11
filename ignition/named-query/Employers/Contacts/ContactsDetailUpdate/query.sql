UPDATE	organization.EmployerContacts
SET employerId = :employer_id,
	firstName = :FirstName,
	lastName =  :LastName,
	phone =  :Phone,
	email =  :Email,
    timeCreated = :time_created,
    username = :user_name 
WHERE id = :contact_id;
