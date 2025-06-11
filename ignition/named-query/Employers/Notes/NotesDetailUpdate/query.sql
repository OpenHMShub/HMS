UPDATE	organization.EmployerNotes
SET employerId = :employer_id,
	note = :note,
    timeCreated = :time_created,
    userName = :user_name 
WHERE id = :note_id;
