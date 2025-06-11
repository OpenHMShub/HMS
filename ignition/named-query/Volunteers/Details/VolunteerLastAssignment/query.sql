SELECT C.title, I.startDate, I.venue, I.room
from calendar.eventInstanceVolunteers IV
left join calendar.eventInstances I on I.instanceID = IV.instanceID
left join calendar.Tasks T on T.taskId = IV.taskID
left join calendar.CalendarEvents C on C.eventID = I.parentEventID
WHERE IV.volunteerID = :volunteerId and I.startDate < GETDATE() ORDER BY I.startDate DESC