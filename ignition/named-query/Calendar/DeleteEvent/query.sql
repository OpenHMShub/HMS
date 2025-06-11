UPDATE calendar.CalendarEvents 
SET deleted = 1
WHERE
eventID = :eventID