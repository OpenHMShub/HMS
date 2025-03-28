INSERT INTO 
	[participant].[EventSelectedAttendeeCategories]
	([attendeeCategoryId] ,[eventId] ,[timeCreated],[timeRetired])
Values
	(:attendeeCategoryId, :eventId, CURRENT_TIMESTAMP, NULL)
