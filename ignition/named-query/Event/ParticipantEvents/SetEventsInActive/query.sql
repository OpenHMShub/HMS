UPDATE [participant].[Events] 
SET timeRetired = GETDATE()
WHERE id in (

	SELECT e.id
     FROM
   [participant].[Events] e
   LEFT JOIN ( 
				SELECT eventId, max(startsOn)  as lastEventTime
				   FROM [participant].[EventSchedule]
				   WHERE timeRetired IS NULL and timeCancelled is NULL AND 
				   startsOn < GETDATE() group by eventId
			) l on l.eventId = e.id
   LEFT JOIN ( 
				SELECT eventId, min(startsOn)  as nextEventTime
				FROM [participant].[EventSchedule]
				WHERE  timeRetired IS NULL and timeCancelled is NULL
				AND startsOn >= GETDATE() group by eventId
			 ) n on n.eventId = e.id
WHERE l.lastEventTime < DATEADD(month, -1,GETDATE()) and n.nextEventTime is NULL
)