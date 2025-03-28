Update
	[participant].[EventWeeklyScheduleNote]
SET
	[note] = :note
Where
	[locationId] = :locationId
 	 AND [date] = :date