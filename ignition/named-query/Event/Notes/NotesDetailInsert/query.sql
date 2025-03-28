INSERT INTO	participant.EventNotes
	(
	eventId,
	note, 
    timeCreated,
    userName 
	)
VALUES
	(
 	:event_id,
    :note,     
    :time_created,
    :user_name
	)