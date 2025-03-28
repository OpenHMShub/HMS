SELECT 
	s.[id]
	,s.[eventId]
	,s.[day]
	,s.[year]
	,s.[month]
	,s.[notes]
	,FORMAT (s.[startsOn], 'MM-dd-yyyy HH:mm:ss') as 'startsOn'
	,FORMAT (s.[startsOn], 'MM/dd/yy') as 'date'
	,FORMAT (s.[startsOn], 'hh:mm tt') as 'time'
	,FORMAT (s.[endsOn], 'MM-dd-yyyy HH:mm:ss') as 'endsOn'
	,s.[duration] as 'duration'
	,s.locationId
	,(select STRING_AGG(facilitatorHumanId,',') from [participant].[EventSheduleSelectedFacilitators] where scheduleId = s.[id]) as 'facilitatorHumanId'
	,ISNULL((select name from [participant].[EventLocations] where id = s.locationId),'') as 'location'
	,s.[points]
	,ISNULL(s.[description],'') as 'description'
	,(select count(id) from participant.EventAttendance where scheduleId = s.id and timeRetired IS NULL) as 'attendance'
FROM
	[participant].[EventSchedule] s
LEFT JOIN
	[participant].[Events] e ON s.eventId = e.id
WHERE
	s.eventId = :EventId
	AND s.[timeRetired] IS NULL
ORDER BY
	s.[startsOn]
  