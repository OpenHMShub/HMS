SELECT sum(DATEDIFF(hour, I.startDate, I.endDate)) as hours, DATEADD(month, DATEDIFF(month, 0, I.startDate), 0) as time
from calendar.eventInstanceVolunteers IV
inner join calendar.eventInstances I on I.instanceID = IV.instanceID
WHERE I.startDate < GETDATE()
GROUP BY IV.volunteerID, DATEADD(month, DATEDIFF(month, 0, I.startDate), 0)
HAVING IV.volunteerID = :volunteerId;