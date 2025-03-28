SELECT sum(DATEDIFF(minute, EA.checkin, EA.checkout)) as val
FROM calendar.EventAttendance EA
LEFT JOIN calendar.CalendarEvents CE on CE.id = EA.eventID
LEFT JOIN staff.volunteer V on V.humanId = EA.humanId
WHERE YEAR(EA.checkin) = YEAR(GETDATE()) and EA.checkin < GETDATE();