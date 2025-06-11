SELECT V.id
FROM 
	staff.Volunteer as V
	LEFT JOIN humans.Human as H ON H.id = V.humanId
WHERE
	COALESCE(H.firstName, '') = :firstName
	AND COALESCE(H.middleName, '') = :middleName
	AND COALESCE(H.lastName, '') = :lastName