SELECT E.id
FROM 
	staff.Employee as E
	LEFT JOIN humans.Human as H ON H.id = E.humanId
WHERE
	COALESCE(H.firstName, '') = :firstName
	AND COALESCE(H.middleName, '') = :middleName
	AND COALESCE(H.lastName, '') = :lastName