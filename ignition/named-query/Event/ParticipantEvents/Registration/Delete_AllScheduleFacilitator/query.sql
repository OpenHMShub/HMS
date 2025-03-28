-- First delete all records for selected event
DELETE FROM
	[participant].[EventSheduleSelectedFacilitators]
Where
	[scheduleId] in (select id from participant.EventSchedule where [eventId] = :eventId and [timeRetired] IS NULL and [startsOn] >= :limitDate)
