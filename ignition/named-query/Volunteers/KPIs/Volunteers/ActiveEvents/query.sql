SELECT count(CE.id)
FROM calendar.CalendarEvents CE 
WHERE CE.startDate < GETDATE() and EI.endDate > GETDATE()