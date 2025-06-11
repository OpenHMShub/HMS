SELECT
	organization.EmployerNotes.id AS 'id',
	organization.EmployerNotes.employerId AS 'employer_id',
	organization.EmployerNotes.note as 'note',
	organization.EmployerNotes.timeCreated AS 'time_created'
FROM
	organization.EmployerNotes
WHERE 	
	organization.EmployerNotes.employerId = :employer_id	 
ORDER BY time_created DESC