SELECT
	s.id as 'scheduleId',
	s.startsOn as 'scheduleDate',
	e.id as 'eventId',
	(SELECT CASE WHEN COUNT(participantId) > 0 THEN 'Checked-In'
	ELSE 'Scheduled' END AS status
	 FROM participant.EventAttendance 
	 WHERE scheduleId = s.id AND timeRetired IS NULL) as status,
	 COALESCE(l.name , '') as eventLocations,
	 e.name as eventName,
	 (SELECT COUNT(participantId) 
	 FROM participant.EventAttendance 
	 WHERE scheduleId = s.id AND timeRetired IS NULL) as noOfAttendees,
	 s.points
FROM participant.EventSchedule  s 
JOIN participant.Events  e ON s.eventId = e.id
LEFT JOIN participant.EventLocations l ON e.locationId = l.id

WHERE  e.timeRetired is NULL and s.timeRetired IS NULL and s.day =  :day AND s.month =  :month and s.year = :year AND s.timeCancelled is NULL
