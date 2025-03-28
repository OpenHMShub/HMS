SELECT * FROM
(
SELECT att.*,  ISNULL(el.name,'') as 'location'
FROM
(
	SELECT  
		
		e.name as 'EventName',
		e.locationId,
		e.[categoryId] as 'categoryId',
		1  as 'CheckInOut',
		'checkin' as 'Check In/Out',
--		(SELECT checkin FROM participant.EventAttendance WHERE scheduleId = es.id and timeRetired IS NULL)  as 'date' ,
		CAST(es.startsOn as date) as 'date' ,
		es.startsOn,
		es.endsOn,
		es.duration as duration_hours,
		ISNULL((SELECT COUNT(id) FROM participant.EventAttendance WHERE scheduleId = es.id and timeRetired IS NULL), 0) as attendance,
		ISNULL(es.description,'') as 'description',
		ISNULL((
			SELECT STRING_AGG(concat(h.firstName,
				CASE when (h.middleName IS NULL or h.middleName='') then '' else ' ' end,
				h.middleName,
				CASE when (h.lastName IS NULL or h.lastName='') then '' else ' ' end,
				h.lastName
			) , ', ') as facilitatorName
			FROM  participant.EventSheduleSelectedFacilitators  f
			LEFT JOIN [humans].[Human] h ON f.[facilitatorHumanId] = h.id 
			WHERE f.scheduleId = es.id 					
			), '') as facilitator
	FROM 
		participant.Events e, 
		participant.EventSchedule es
	WHERE 
		es.eventId = e.id
		AND es.timeRetired is NULL
		AND ( :facilitatorId IS NULL OR :facilitatorId = -1 OR :facilitatorId IN ((SELECT  facilitatorHumanId FROM participant.EventSelectedFacilitators WHERE eventId = e.id )))
		
) att LEFT JOIN  participant.EventLocations el on el.id = att.locationId
WHERE
	(:CategoryId IS NULL OR att.categoryId = :CategoryId )
	
	AND  {EventName} 
	AND (:dateFrom IS NULL OR att.[date] >= :dateFrom )
	AND (:dateTo IS NULL OR att.[date] <= :dateTo )
	AND (:beginDate IS NULL OR att.[date] >= :beginDate )
	AND (:endDate IS NULL OR att.[date] <= :endDate )
	
	AND (
		:searchText = '' 
		OR :searchText IS NULL 
		OR att.EventName LIKE CONCAT('%',:searchText,'%')
)
)mainTable
ORDER BY 
	mainTable.[date] desc, mainTable.startsOn desc