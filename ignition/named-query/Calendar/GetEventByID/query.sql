SELECT *
FROM calendar.CalendarEvents
WHERE deleted = 0 AND eventID = COALESCE(:eventID, 0)