INSERT INTO
	[participant].[EventWeeklyScheduleNote]
	([time],[date],[locationId],[note],[timeCreated])
Values
	(:time,:date,:locationId,:note,CURRENT_TIMESTAMP)