SELECT
	participant.EventNotes.id AS 'id',
	participant.EventNotes.eventId  AS 'event_id',
	participant.EventNotes.note as 'note',
	participant.EventNotes.timeCreated AS 'time_created'
FROM
	participant.EventNotes 
WHERE 	
	participant.EventNotes.eventId = :event_id 
ORDER BY time_created DESC