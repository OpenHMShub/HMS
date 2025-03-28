SELECT DateFromParts(Year(max([checkIn])),Month(max([checkIn])),1) as 'time'
	,count([participantId]) AS 'applicants'
FROM
(
SELECT e.[id]
      ,e.[categoryId]
      ,e_cat.[category] as 'category'
      ,e.[name]
      ,es.[startsOn]
      ,es.[endsOn]
      ,e.duration_hours as duration
      ,e.[allDayEvent]
      ,e.[description]
      ,e.[repeatFrequencyTypeId]
      ,e.[dateSelectionPattern]
      ,e.[dateSelectionDays]
      ,e.[timeCreated]
      ,e.[timeRetired]
      ,e.[points]
      ,e.scheduledWeekdays as 'nightsInt'
	  ,cast(e.scheduledWeekdays & 1 as bit) as 'sunday'
	  ,cast(e.scheduledWeekdays & 2 as bit) as 'monday'
	  ,cast(e.scheduledWeekdays & 4 as bit) as 'tuesday'
	  ,cast(e.scheduledWeekdays & 8 as bit) as 'wednesday'
	  ,cast(e.scheduledWeekdays & 16 as bit) as 'thursday'
	  ,cast(e.scheduledWeekdays & 32 as bit) as 'friday'
	  ,cast(e.scheduledWeekdays & 64 as bit) as 'saturday'
	  ,l.name as locationName
	  ,ea.participantId
	  ,ea.checkIn 
FROM [participant].[Events] e
LEFT JOIN (select id, name as 'category' FROM [participant].[EventCategories]) e_cat on e.[categoryId] = e_cat.id
LEFT JOIN [participant].[EventLocations] l ON e.locationId = l.id
LEFT JOIN  participant.EventSchedule es ON es.eventId = e.id
LEFT JOIN  participant.EventAttendance ea on ea.scheduleId = es.id
WHERE 
ea.timeRetired is NULL AND es.timeRetired is NULL 
AND e.id = :EventId
) x
GROUP BY
	Month([checkIn])