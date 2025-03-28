SELECT eventId, checkin, ce.name, p.id as participantId
FROM calendar.EventAttendance cea, participant.Participant p, calendar.CalendarEvents ce
WHERE cea.humanId = p.humanId and cea.eventId = ce.id
AND p.id =  :participantId 
AND ( :eventName IS NULL or ce.name  LIKE  :eventName )
ORDER BY cea.checkin