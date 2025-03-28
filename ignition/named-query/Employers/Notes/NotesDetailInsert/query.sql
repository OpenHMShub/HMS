INSERT INTO	organization.EmployerNotes
	(
	employerId,
	note, 
    timeCreated,
    userName 
	)
VALUES
	(
 	:employer_id,
    :note,
    :time_created,
    :user_name
	)