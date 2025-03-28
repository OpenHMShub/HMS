-- First delete all records for selected event
DELETE FROM
	[participant].[EventSelectedAttendeeCategories]
Where
	[eventId] = :eventId
