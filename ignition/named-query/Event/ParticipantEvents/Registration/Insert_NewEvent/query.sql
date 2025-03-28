INSERT INTO [participant].[Events]
	([categoryId],[name],[startsOn],[endsOn],[allDayEvent],[description],[repeatFrequencyTypeId],[dateSelectionPattern],[dateSelectionDays],[timeCreated],[timeRetired],[points],[facilitatorEmployeeId],[IsEventRepeat],[repeatDateUntil],[scheduledWeekdays],[duration_hours],[locationId])
Values
	(:categoryId,:eventName,:startsOn,:endsOn,:all_day,:description,:repeatFrequencyTypeId,:dateSelectionPattern,:dateSelectionDays,:timeCreated,:timeRetired,:points,:facilitatorEmployeeId,:IsEventRepeat,:repeatDateUntil,:scheduledWeekdays,:duration_hours,:locationId)