SELECT  ea.id , es.startsOn, es.startsOn as startTime,  es.duration as duration_hours, e.name, COALESCE(es.description, '') as description, ea.participantId ,
e.locationId, COALESCE((select name from participant.EventLocations where id = es.locationId), '') as 'location',
(SELECT COUNT(id) FROM participant.EventAttendance WHERE scheduleId = es.id and timeRetired IS NULL) as attendance
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
AND (es.startsOn >= :dateRangeStart OR :dateRangeStart IS NULL)
AND (es.startsOn <= :dateRangeEnd OR :dateRangeEnd IS NULL)
AND
(:selectedEventName IS NULL or  :selectedEventName = '' OR (e.[name] like ('%'+ :selectedEventName + '%')))
AND
( :selectedCategoryId IS NULL or  :selectedCategoryId = -1 OR e.[categoryId] = :selectedCategoryId)

AND
( :searchText IS NULL or  :searchText = '' OR 
e.[description] LIKE ('%'+ :searchText + '%') OR
e.[name] LIKE ('%'+ :searchText + '%')
)
ORDER BY es.startsOn desc