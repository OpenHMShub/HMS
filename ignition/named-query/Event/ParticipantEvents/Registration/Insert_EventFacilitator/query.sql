INSERT INTO 
	[participant].[EventSelectedFacilitators]
	([facilitatorHumanId] ,[eventId] ,[timeCreated],[timeRetired])
Values
	(:facilitatorHumanId, :eventId, CURRENT_TIMESTAMP, NULL)
