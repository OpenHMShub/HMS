SELECT * FROM
(
SELECT att.*,  ISNULL(el.name,'') as 'location', CASE WHEN f.facilityName IS NULL THEN 'Hope U' 
WHEN f.facilityName like '%Apartment%' THEN 'Residents (Apartments)' ELSE 'Guest House' 
END as shelterName
FROM
(
	SELECT  
		p.id as 'id',
		ea.id as 'AttendanceId',
		ea.participantId ,
		CONCAT_WS(' ', h.[firstName],h.[middleName],h.[lastName]) AS 'ParticipantName',
		e.name as 'EventName',
		e.locationId,
		-- ISNULL((select name from participant.EventLocations where id = e.locationId),'') as 'location',
		e.[categoryId] as 'categoryId',
		1  as 'CheckInOut',
		'checkin' as 'Check In/Out',
		ea.checkin  as 'date' ,
		h.dob as BirthDate,
		h.genderId as GenderId,
		DATEDIFF(year,h.dob,GETDATE()) AS Age,
		g.genderName as Gender,
		es.startsOn,
		es.endsOn,
		es.duration as duration_hours,
		(SELECT COUNT(id) FROM participant.EventAttendance WHERE scheduleId = es.id and timeRetired IS NULL) as attendance,
		ISNULL(es.description,'') as 'description',
		CASE WHEN p.timeRetired IS NULL THEN 1
		ELSE 0 END as isActive,
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
		participant.EventSchedule es,
		participant.EventAttendance ea, 
		participant.participant p,
		humans.human h,
		humans.Gender g
	WHERE 
		ea.participantId = p.id 
		AND ea.scheduleId = es.id
		AND es.eventId = e.id
		AND p.humanId = h.id
		
		AND g.id = h.genderId
		AND ea.timeRetired is null 
		AND es.timeRetired is NULL
		AND ( :facilitatorId IS NULL OR :facilitatorId = -1 OR :facilitatorId IN ((SELECT  facilitatorHumanId FROM participant.EventSelectedFacilitators WHERE eventId = e.id )))
		
) att LEFT JOIN  participant.EventLocations el on el.id = att.locationId
LEFT JOIN
lodging.BedLog bl on bl.participantId = att.participantId and bl.eventStart <= att.date and ( bl.eventEnd IS NULL or bl.eventEnd >= att.date)
LEFT JOIN lodging.Bed b ON bl.bedId = b.id
LEFT JOIN lodging.Room r on b.roomId = r.id
LEFT JOIN lodging.Facility f on r.facilityId = f.id
WHERE
	(:CategoryId IS NULL OR att.categoryId = :CategoryId )
	
	AND  {EventName} 
	AND (:dateFrom IS NULL OR att.[date] >= :dateFrom )
	AND (:dateTo IS NULL OR att.[date] <= :dateTo )
	AND (:genderId IS NULL OR att.GenderId = :genderId )
	AND (:programId IS NULL OR :programId IN (SELECT programId FROM participant.Enrollments where particpantId = att.id))
	AND (:beginDate IS NULL OR att.[date] >= :beginDate )
	AND (:endDate IS NULL OR att.[date] <= :endDate )
	
	AND (
		:searchText = '' 
		OR :searchText IS NULL 
		OR att.ParticipantName LIKE CONCAT('%',:searchText,'%') 
		OR att.EventName LIKE CONCAT('%',:searchText,'%')
		OR att.Gender LIKE CONCAT('%',:searchText,'%') 
)
)mainTable
WHERE (:filterByAttendeeCategories = 0 OR {selectedAttendeeCategories} )
ORDER BY 
	mainTable.[date] desc