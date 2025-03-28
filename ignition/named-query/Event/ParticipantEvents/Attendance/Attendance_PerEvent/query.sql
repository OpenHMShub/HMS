SELECT * FROM
(
	SELECT  
		p.id as 'id',
		ea.id as 'AttendanceId',
		ea.participantId ,
		CONCAT_WS(' ', h.[firstName],h.[middleName],h.[lastName]) AS 'ParticipantName',
		e.name as 'EventName',
		e.[categoryId] as 'categoryId',
		ea.checkin as 'date',
		es.startsOn,
		h.dob as BirthDate,
		h.genderId as GenderId,
		DATEDIFF(year,h.dob,GETDATE()) AS Age,
		g.genderName as Gender,
		es.endsOn,
		es.duration as duration_hours,
		(SELECT COUNT(id) FROM participant.EventAttendance WHERE scheduleId = es.id and timeRetired IS NULL) as attendance,
		es.description,
		CASE WHEN p.timeRetired IS NULL THEN 1
		ELSE 0 END as isActive
	FROM 
		participant.Events e, 
		participant.EventSchedule es,
		participant.EventAttendance ea, 
		participant.participant p,
		humans.human h,
		humans.Gender g 
	WHERE 
		ea.participantId = p.id 
		AND e.id = :EventId
		AND ea.scheduleId = es.id
		AND es.eventId = e.id
		AND p.humanId = h.id
		AND g.id = h.genderId
		AND ea.timeRetired is null 
		AND es.timeRetired is NULL
) att
WHERE
	(:CategoryId IS NULL OR att.categoryId = :CategoryId)
	
	AND (:dateFrom IS NULL OR att.[date] >= :dateFrom )
	AND (:dateTo IS NULL OR att.[date] <= :dateTo)
	AND (:genderId IS NULL OR att.GenderId = :genderId )
	AND (:programId IS NULL OR :programId IN (SELECT programId FROM participant.Enrollments where particpantId = att.id))
	AND (:minAge IS NULL OR att.Age >= :minAge)
	AND (:maxAge IS NULL OR att.Age <= :maxAge)
	AND (:beginDate IS NULL OR att.[date] >= :beginDate)
	AND (:endDate IS NULL OR att.[date] <= :endDate)
	AND (
		:searchText = '' 
		OR :searchText IS NULL 
		OR att.ParticipantName LIKE CONCAT('%',:searchText,'%') 
		OR att.Gender LIKE CONCAT('%',:searchText,'%') 
		
)
ORDER BY 
	att.[date]