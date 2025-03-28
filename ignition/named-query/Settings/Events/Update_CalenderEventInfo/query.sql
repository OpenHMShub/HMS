UPDATE
	calendar.CalendarEvents
SET
	description = :description,
	duration = :duration
WHERE
	id = :id