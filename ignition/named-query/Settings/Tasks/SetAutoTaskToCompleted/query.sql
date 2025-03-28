UPDATE
	participant.Tasks
SET
	completedDate = CURRENT_TIMESTAMP
WHERE
	participantId = :participantId
	AND title = :subject
	AND {note}