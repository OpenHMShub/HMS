select es.day , count( distinct es.id) as noOfEvents , count(ea.participantId) as noOfAttendees
from participant.EventSchedule es 
JOIN participant.Events e ON es.eventId = e.id
LEFT JOIN participant.EventAttendance ea ON ea.scheduleId = es.id 
where  e.timeRetired is NULL and es.month = :month AND es.year = :year AND es.timeRetired is NULL AND ea.timeRetired is NULL
group by es.day
order by es.day
 
