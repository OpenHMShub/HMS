INSERT INTO 
	[participant].[EventSheduleSelectedFacilitators]
	([facilitatorHumanId] ,[scheduleId] ,[timeCreated],[timeRetired])
Values
	(:facilitatorHumanId, :scheduleId, CURRENT_TIMESTAMP, NULL)
	

