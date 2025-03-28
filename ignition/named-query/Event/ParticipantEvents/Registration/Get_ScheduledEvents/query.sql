SELECT 
	[eventId],[day],[year],[month],[notes],[timeCreated],[timeUpdated],[timeCancelled],[timeRetired],startsOn,endsOn, id as scheduleId
FROM
	[participant].[EventSchedule]
WHERE
	eventId = :eventId
	AND [timeRetired] IS NULL