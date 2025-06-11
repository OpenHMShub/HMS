SELECT 
	E.id,
	CASE
		WHEN isNull(H.middleName, '') = '' THEN CONCAT(H.firstName, ' ', H.lastName)
		ELSE CONCAT(H.firstName, ' ', H.middleName, ' ', H.lastName)
	END as name
FROM
	calendar.eventStaff as eventStaff
	LEFT JOIN staff.Employee as E ON E.id = eventStaff.staffID
	LEFT JOIN humans.Human as H ON H.id = E.humanId
WHERE
	eventStaff.eventID = :eventID