SELECT e.[id]
      ,e.[categoryId]
      ,e_cat.[category] as 'category'
      ,e.[name]
      ,e.[startsOn]
      ,e.[endsOn]
      ,e.[allDayEvent]
      ,e.[description]
      ,e.[repeatFrequencyTypeId]
      ,e.[dateSelectionPattern]
      ,e.[dateSelectionDays]
      ,e.[timeCreated]
      ,e.[timeRetired]
      ,e.[points]
      ,e.facilitatorEmployeeId
      ,(select STRING_AGG([facilitatorHumanId], ',') as facilitator from [participant].[EventSelectedFacilitators] where [eventId] = e.id) as 'facilitatorHumanId'
      ,(select STRING_AGG([attendeeCategoryId], ',') as attendeeCategories from [participant].[EventSelectedAttendeeCategories] where [eventId] = e.id) as 'attendeeCategories'
      ,(select STRING_AGG(ec.name, ',')  from participant.EventAttendeeCategories ec,  [participant].[EventSelectedAttendeeCategories] esc where esc.eventId = e.id and ec.id = esc.attendeeCategoryId ) as 'attendeeCategoryNames'
      ,ISNULL((
			SELECT STRING_AGG(concat(h.firstName,
				CASE when (h.middleName IS NULL or h.middleName='') then '' else ' ' end,
				h.middleName,
				CASE when (h.lastName IS NULL or h.lastName='') then '' else ' ' end,
				h.lastName
			) , ', ') as facilitatorName
			FROM [participant].[EventSelectedFacilitators] f
			LEFT JOIN [humans].[Human] h ON f.[facilitatorHumanId] = h.id 
			WHERE f.eventId = e.id 
			
			
), '')  as 'facilitator'
      ,e.[IsEventRepeat]
      ,e.[repeatDateUntil]
      ,e.[scheduledWeekdays]
      ,e.[duration_hours]
      ,e.[locationId]
      ,loc.location as 'location'
      ,(SELECT TOP 1 startsOn FROM [participant].[EventSchedule] where timeRetired is NULL AND eventId = e.id ORDER BY startsOn DESC) as eventLastOccurance
FROM [participant].[Events] e
LEFT JOIN (select * FROM [participant].[EventSchedule] where timeRetired IS NULL) es ON e.id = es.eventId and e.startsOn = es.startsOn
LEFT JOIN (select id, name as 'category' FROM [participant].[EventCategories]) e_cat on e.[categoryId] = e_cat.id
LEFT JOIN (select id, name as 'location' FROM participant.EventLocations) loc on e.[locationId] = loc.id

WHERE e.id = :eventId