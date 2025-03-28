SELECT  TOP 1 id as scheduleId, startsOn as prevDate 
FROM participant.EventSchedule
WHERE 
eventId = :eventId
AND timeRetired is null
AND startsOn <= GETDATE()
ORDER BY startsOn desc
