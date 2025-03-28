
SELECT COUNt(DISTINCT id) as TotalEvents, COUNT(participantId) as TotalAttendees, COUNT(DISTINCT participantId) as activeParticipants FROM
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
      ,p.id as 'participantId'
      ,CONCAT_WS(' ', h.[firstName],h.[middleName],h.[lastName]) AS 'ParticipantName'
     
	  ,h.genderId as GenderId
	  ,DATEDIFF(year,h.dob,GETDATE()) AS Age
	  ,g.genderName as Gender
     
     
      ,case when ea.[checkout] IS NULL then 1 else 0 end as 'CheckInOut'
      ,case when ea.[checkout] IS NULL then 'checkin' else 'checkout' end as 'Check In/Out'
      ,e.scheduledWeekdays as 'nightsInt'
	  ,cast(e.scheduledWeekdays & 1 as bit) as 'sunday'
	  ,cast(e.scheduledWeekdays & 2 as bit) as 'monday'
	  ,cast(e.scheduledWeekdays & 4 as bit) as 'tuesday'
	  ,cast(e.scheduledWeekdays & 8 as bit) as 'wednesday'
	  ,cast(e.scheduledWeekdays & 16 as bit) as 'thursday'
	  ,cast(e.scheduledWeekdays & 32 as bit) as 'friday'
	  ,cast(e.scheduledWeekdays & 64 as bit) as 'saturday'
	  ,l.name as locationName
	 , CASE WHEN f.facilityName IS NULL THEN 'Hope U' 
WHEN f.facilityName like '%Apartment%' THEN 'Residents (Apartments)' ELSE 'Guest House' 
END as shelterName
FROM [participant].[Events] e
	LEFT JOIN (select id, name as 'category' FROM [participant].[EventCategories]) e_cat on e.[categoryId] = e_cat.id
	LEFT JOIN [participant].[EventLocations] l ON e.locationId = l.id
	LEFT JOIN  participant.EventSchedule es ON es.eventId = e.id
	LEFT JOIN  participant.EventAttendance ea on ea.scheduleId = es.id

	LEFT JOIN participant.participant p ON ea.participantId = p.id
	LEFT JOIN 	humans.human h ON p.humanId = h.id
	LEFT JOIN 	humans.Gender g ON h.genderId=g.id
	LEFT JOIN
lodging.BedLog bl on bl.participantId = ea.participantId and bl.eventStart <= ea.checkin and ( bl.eventEnd IS NULL or bl.eventEnd >= ea.checkin)
LEFT JOIN lodging.Bed b ON bl.bedId = b.id
LEFT JOIN lodging.Room r on b.roomId = r.id
LEFT JOIN lodging.Facility f on r.facilityId = f.id
WHERE 
	ea.timeRetired is NULL AND es.timeRetired is NULL 
	AND (:facilitatorId = -1 OR :facilitatorId IS NULL OR :facilitatorId IN (SELECT  facilitatorHumanId FROM participant.EventSelectedFacilitators WHERE eventId = e.id ))
	
) x 
WHERE
	(:CategoryId IS NULL OR x.[categoryId] = :CategoryId)
	
	AND  {EventName} 
	AND (:dateFrom IS NULL OR x.startsOn >= :dateFrom  )
	AND (:dateTo IS NULL OR x.startsOn <= :dateTo)
	AND (:genderId IS NULL OR x.GenderId = :genderId)
	AND (:programId IS NULL OR :programId IN (SELECT programId FROM participant.Enrollments where particpantId = x.participantId))
	AND (:minAge IS NULL OR x.Age >= :minAge )
	AND (:maxAge IS NULL OR x.Age <= :maxAge)
	AND (:beginDate IS NULL OR x.startsOn >= :beginDate )
	AND (:endDate IS NULL OR x.startsOn <= :endDate)
	AND
	(:filterByAttendeeCategories = 0 OR {selectedAttendeeCategories} )
	AND (
		:searchText = '' 
		OR :searchText IS NULL 
		OR x.ParticipantName LIKE CONCAT('%',:searchText,'%') 
		OR x.name LIKE CONCAT('%',:searchText,'%')
		OR x.Gender LIKE CONCAT('%',:searchText,'%') 
		)
	AND x.participantId IS NOT NULL
