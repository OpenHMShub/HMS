---Volunteers/Dashboard/Select Volunteers---
WITH v as (SELECT CONCAT(H.firstName,' ',H.middleName,' ',H.lastName) as "Name", 
		H.phone as "Phone Number",
		H.email as Email, 
		H.dob as "dob", 
		DATEDIFF(year, H.dob, getDate()) as Age,
		CE.name as EventName,
		CE.startDate as EventDate,
		CE.calendarId as calendarId,
		h.id,
		ea.checkin,
		ea.checkout,
		DATEDIFF(minute, ea.checkin, ea.checkout)/60.0 as Hours,
		g.genderName [Gender],
		ea.id [eventAttendeeId]
	FROM staff.Volunteer V
	Inner join humans.Human H on H.id = V.humanId 
	INNER JOIN calendar.EventAttendance EA on ea.humanId = h.id
	INNER JOIN calendar.CalendarEvents CE on ce.id = ea.eventID
	LEFT JOIN humans.gender g on h.genderId = g.id
	WHERE V.timeRetired is null AND CE.startDate >= DATEADD(DAY, -:dayRange , getDate())
)
SELECT *
FROM v
WHERE 
	{calendarId}
	AND {EventDate}
-- where Name LIKE '%' + :search + '%'
;