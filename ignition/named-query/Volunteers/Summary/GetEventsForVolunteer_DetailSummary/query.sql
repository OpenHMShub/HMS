SELECT 
    ce.name AS EventName,
    FORMAT(ei.startDate, 'yyyy-MM-dd HH:mm:ss') AS StartDate,
    FORMAT(ei.endDate, 'yyyy-MM-dd HH:mm:ss') AS EndDate
FROM calendar.eventInstanceVolunteers eiv
JOIN calendar.eventInstances ei
    ON eiv.instanceID = ei.instanceID
JOIN calendar.CalendarEvents ce
    ON ei.parentEventID = ce.id
WHERE eiv.volunteerID = :volunteerID
  AND ce.name LIKE '%' + :EventName + '%';