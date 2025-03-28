SELECT * 
FROM
	participant.Tasks
WHERE
	participantId = :participantId
	AND title = :subject
	AND completedDate IS NULL
	AND staffId = :staffId
	AND timeRetired IS NULL