SELECT 
	V.id,
	CASE
		WHEN isNull(H.middleName, '') = '' THEN CONCAT(H.firstName, ' ', H.lastName)
		ELSE CONCAT(H.firstName, ' ', H.middleName, ' ', H.lastName)
	END as name
FROM
	calendar.eventVolunteers as eventVolunteers
	LEFT JOIN staff.Volunteer as V ON V.id = eventVolunteers.volunteerID
	LEFT JOIN humans.Human as H ON H.id = V.humanId
WHERE
	eventVolunteers.eventID = :eventID