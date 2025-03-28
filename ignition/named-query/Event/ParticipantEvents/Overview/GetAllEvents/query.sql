DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());

SELECT * FROM
(
SELECT e.[id]
      ,e.[categoryId]
      ,e_cat.[category] as 'category'
      ,e.[name]
      ,e.[startsOn]
      ,e.[endsOn]
      , duration_hours as duration
      ,e.[allDayEvent]
      ,COALESCE(e.[description], '') as description
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
	  ,COALESCE(l.name, '') as locationName
	  ,fc.fname as 'facilitatorName'
	  ,n.nextEventTime
FROM [participant].[Events] e
LEFT JOIN (select id, name as 'category' FROM [participant].[EventCategories]) e_cat on e.[categoryId] = e_cat.id
LEFT JOIN [participant].[EventLocations] l ON e.locationId = l.id
LEFT JOIN (SELECT pe.eventId, STRING_AGG(CONCAT (firstname, ' ', lastname), ',' ) as fName
FROM humans.human h, participant.EventSelectedFacilitators pe
WHERE h.id = pe.facilitatorHumanId
group by pe.eventId) fc ON fc.eventId = e.id 
LEFT JOIN (SELECT eventId, min(startsOn) as nextEventTime from participant.EventSchedule WHERE timeRetired is NULL 
and timeCancelled IS NULL and CAST(startsOn as DATE) >= CAST (GETDATE() as DATE) group by eventId ) n on n.eventId = e.id
WHERE 
( 
(( :activeInactive IS NULL or :activeInactive = '-1' ) and e.timeRetired IS NULL)
OR
(:activeInactive = 'InActive' and e.timeRetired IS NOT NULL)
OR
(:activeInactive = 'All')
)
AND 
e.id in (SELECT distinct eventId FROM  participant.EventSchedule 
where 
(
(:showFutureEvents = 0 AND startsOn between @activity_start and @activity_end)
OR
(:showFutureEvents = 1 AND startsOn >= @activity_start ) )
and timeRetired is NULL
)
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
(:selectedEventName IS NULL or  :selectedEventName = '' OR (e.[name] like ('%'+ :selectedEventName + '%')))
AND
( :selectedCategoryId IS NULL or  :selectedCategoryId = -1 OR e.[categoryId] = :selectedCategoryId)
AND
( :searchText IS NULL or  :searchText = '' OR 
e_cat.[category] LIKE ('%'+ :searchText + '%') OR
e.[description] LIKE ('%'+ :searchText + '%') OR
e.[name] LIKE ('%'+ :searchText + '%')
)
AND ( :selectedFacilitatorEmployeeId IS NULL or  :selectedFacilitatorEmployeeId = -1 
OR :selectedFacilitatorEmployeeId IN (SELECT  f.facilitatorHumanId FROM participant.EventSelectedFacilitators f where f.eventId = e.id))
AND ( :selectedLocationId IS NULL or  :selectedLocationId = -1 OR e.locationId = :selectedLocationId)
AND ( :selectedPoints IS NULL or  :selectedPoints = -1 OR e.points = :selectedPoints)
AND (  :dateRangeStart IS NULL OR
	   :dateRangeEnd IS NULL OR
	   e.startsOn between :dateRangeStart and :dateRangeEnd 
	) 
) x WHERE {selectedWeekDays}
ORDER BY name