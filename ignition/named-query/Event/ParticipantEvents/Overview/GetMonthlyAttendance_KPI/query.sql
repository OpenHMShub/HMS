DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());

SELECT DateFromParts(Year(max([checkIn])),Month(max([checkIn])),1) as 'time'
	,count([participantId]) AS 'applicants'
FROM
(
SELECT e.[id]
      ,e.[categoryId]
      ,e_cat.[name] as 'category'
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
	  ,d.id as participantId
	  ,ea.checkIn 
FROM [participant].[Events] e
LEFT JOIN [participant].[EventCategories] e_cat on e.[categoryId] = e_cat.id
LEFT JOIN [participant].[EventLocations] l ON e.locationId = l.id
LEFT JOIN  participant.EventSchedule es ON es.eventId = e.id
LEFT JOIN  participant.EventAttendance ea on ea.scheduleId = es.id
LEFT JOIN participant.participant d ON ea.participantId = d.ID 
WHERE
( 
(( :activeInactive IS NULL or :activeInactive = '-1' ) and e.timeRetired IS NULL)
OR
(:activeInactive = 'InActive' and e.timeRetired IS NOT NULL)
OR
(:activeInactive = 'All')
) AND
ea.timeRetired is NULL AND es.timeRetired is NULL AND
(:selectedEventName IS NULL or  :selectedEventName = '' OR (e.[name] like ('%'+ :selectedEventName + '%')))
AND
(
(
(e.id in (
SELECT distinct eventId from participant.EventSelectedAttendeeCategories
where  {selectedAttendeeCategories} 
))
OR
 :filterByAttendeeCategories = 0 )

)
AND
( :selectedCategoryId IS NULL or  :selectedCategoryId = -1 OR e.[categoryId] = :selectedCategoryId)
AND
( :searchText IS NULL or  :searchText = '' OR 
e_cat.[name] LIKE ('%'+ :searchText + '%') OR
e.[description] LIKE ('%'+ :searchText + '%') OR
e.[name] LIKE ('%'+ :searchText + '%')
)
AND ( 
(:showFutureEvents = 0 AND es.startsOn between @activity_start and @activity_end) 
OR 
(:showFutureEvents = 1 AND es.startsOn >= @activity_start) 
	)
AND ( :selectedFacilitatorEmployeeId IS NULL or  :selectedFacilitatorEmployeeId = -1 
OR :selectedFacilitatorEmployeeId IN (SELECT  facilitatorHumanId FROM participant.EventSelectedFacilitators WHERE eventId = e.id))
AND ( :selectedLocationId IS NULL or  :selectedLocationId = -1 OR e.locationId = :selectedLocationId)
AND ( :selectedPoints IS NULL or  :selectedPoints = -1 OR e.points = :selectedPoints)
AND (  :dateRangeStart IS NULL OR
	   :dateRangeEnd IS NULL OR
	   es.startsOn between :dateRangeStart and :dateRangeEnd 
	) 
) x WHERE {selectedWeekDays} 
AND (x.[checkIn] Between DATEADD(month, -6, getDATE()) AND GETDATE())
GROUP BY
	Month([checkIn])
ORDER BY
	Month([checkIn])