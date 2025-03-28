SELECT  TOP 1 id as scheduleId, startsOn as nextDate 
FROM participant.EventSchedule
WHERE 
eventId = :eventId
AND timeRetired is null
AND startsOn > GETDATE()
ORDER BY startsOn 
