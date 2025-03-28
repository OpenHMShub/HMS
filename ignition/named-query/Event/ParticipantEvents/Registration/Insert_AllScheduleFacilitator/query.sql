INSERT INTO 
	[participant].[EventSheduleSelectedFacilitators]
	([facilitatorHumanId] ,[scheduleId] ,[timeCreated],[timeRetired])
select :facilitatorHumanId, id, CURRENT_TIMESTAMP, NULL from participant.EventSchedule where [eventId] = :eventId and [timeRetired] IS NULL and [startsOn] >= :limitDate
