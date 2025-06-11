WITH tempTable AS
(
SELECT 
	F.id,
	CASE
		WHEN isNull(H.middleName, '') = '' THEN CONCAT(H.firstName, ' ', H.lastName)
		ELSE CONCAT(H.firstName, ' ', H.middleName, ' ', H.lastName)
	END as name
FROM
	staff.Facilitator as F
	LEFT JOIN staff.Employee as E ON E.id = F.employeeId
	LEFT JOIN humans.Human as H ON H.id = E.humanId
)

SELECT 
	name as 'value',
	name as 'label',
	id as 'id'
FROM
	tempTable