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
		CASE WHEN ea.checkin > ea.checkout THEN 2
		ELSE DATEDIFF(minute, ea.checkin, ea.checkout)/60.0 END as Hours,
		g.genderName [Gender],
		ea.id [eventAttendeeId]
	FROM staff.Volunteer V
	Inner join humans.Human H on H.id = V.humanId 
	INNER JOIN calendar.EventAttendance EA on ea.humanId = h.id
	INNER JOIN calendar.CalendarEvents CE on ce.id = ea.eventID
	LEFT JOIN humans.gender g on h.genderId = g.id
	WHERE V.timeRetired is null AND CE.startDate >= DATEADD(DAY, -:dayRange , getDate())
	UNION 
	SELECT CONCAT(H.firstName,' ',H.middleName,' ',H.lastName) as "Name", 
		H.phone as "Phone Number",
		H.email as Email, 
		H.dob as "dob", 
		DATEDIFF(year, H.dob, getDate()) as Age,
		e.name as EventName,
		es.startsOn as EventDate,
		e.categoryId as calendarId,
		h.id,
		es.startsOn as checkin,
		es.endsOn as checkout,
		CASE WHEN es.duration < 0 THEN 2 
		ELSE es.duration END as Hours,
		g.genderName [Gender],
		es.id [eventAttendeeId]
	FROM
		participant.EventSchedule es 
		INNER JOIN participant.Events e on es.eventId = e.id
		INNER JOIN participant.EventSheduleSelectedFacilitators f on f.scheduleId = es.id
		INNER JOIN humans.Human H on H.id = f.facilitatorHumanId
		INNER JOIN staff.Volunteer vl on f.facilitatorHumanId = vl.humanId
		LEFT JOIN humans.gender g on h.genderId = g.id
		WHERE es.timeRetired IS NULL and e.timeRetired IS NULL AND es.startsOn >= DATEADD(DAY, -:dayRange , getDate()) and es.startsOn < DATEADD(DAY, 1, getDate())
)
SELECT *
FROM v
WHERE 
	{calendarId}
	AND {EventDate}
ORDER BY checkin desc
-- where Name LIKE '%' + :search + '%'
;