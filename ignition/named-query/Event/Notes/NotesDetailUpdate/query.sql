UPDATE participant.EventNotes 
SET eventId = :event_id,
	note = :note,
	userName = :user_name
WHERE id = :note_id
