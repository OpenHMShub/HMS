SELECT * 
FROM
	shelter.Tasks 
WHERE
	locationId = :locationId
	AND title = :subject
	AND dueDate = :dueDate
	AND staffId = :staffId
	AND timeRetired IS NULL