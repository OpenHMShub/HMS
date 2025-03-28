SELECT  ea.id , es.startsOn, es.duration as duration_hours, e.name, es.description, ea.participantId
FROM participant.Events e, 
 participant.EventSchedule es,
participant.EventAttendance ea, 
participant.Dashboard d
WHERE 
ea.participantId = d.ID 
AND ea.participantId = :participantId 
AND ea.scheduleId = es.id
AND es.eventId = e.id
AND ea.timeRetired is null 
AND es.timeRetired is NULL

AND
(:selectedEventName IS NULL or  :selectedEventName = '' OR (e.[name] like ('%'+ :selectedEventName + '%')))

ORDER BY es.startsOn