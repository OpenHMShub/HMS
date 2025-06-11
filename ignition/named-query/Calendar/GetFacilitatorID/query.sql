SELECT F.id
FROM 
	staff.Facilitator as F
	LEFT JOIN staff.Employee as E ON E.id = F.employeeId
	LEFT JOIN humans.Human as H ON H.id = E.humanId
WHERE
	COALESCE(H.firstName, '') = :firstName
	AND COALESCE(H.middleName, '') = :middleName
	AND COALESCE(H.lastName, '') = :lastName