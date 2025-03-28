-- First delete all records for selected event
DELETE FROM
	[participant].[EventSelectedFacilitators]
Where
	[eventId] = :eventId
