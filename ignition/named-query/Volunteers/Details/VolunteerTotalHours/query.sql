SELECT top 1 sum(DATEDIFF(hour, I.startDate, I.endDate))
from calendar.eventInstanceVolunteers IV
inner join calendar.eventInstances I on I.instanceID = IV.instanceID
WHERE I.startDate < GETDATE() and IV.volunteerID = :volunteerId and IV.validation = 1
GROUP BY IV.volunteerID;