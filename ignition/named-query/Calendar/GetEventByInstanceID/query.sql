--SELECT E.eventID, E.title, E.category, E.subCategory, E.description, I.venue, DATEDIFF(minute, I.startDate, I.endDate) as minutes

SELECT E.id as eventID, E.name as title, E.description, I.venue, DATEDIFF(minute, I.startDate, I.endDate) as minutes
FROM calendar.eventInstances I
LEFT JOIN calendar.CalendarEvents E on E.id = I.parentEventID
WHERE I.instanceID = :instanceId