SELECT 
eventID, category, endDate,  subCategory,
startDate, title,eventID
FROM calendar.CalendarEvents
WHERE 
deleted = 0 AND (endDate <= GETDATE())
ORDER BY endDate DESC