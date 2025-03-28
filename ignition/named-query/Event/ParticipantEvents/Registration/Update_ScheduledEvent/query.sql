--Update schedule evnt dates
UPDATE  [participant].[EventSchedule]
SET 
	duration = :duration,
	locationId = :locationId,
	points = :points,
	description = :description
WHERE 
	id in (select id from participant.EventSchedule where [eventId] = :eventId and [timeRetired] IS NULL)
	and [startsOn] >= :limitDate

