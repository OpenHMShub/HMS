WITH tempTable AS
(
SELECT 
	E.id,
	CASE
		WHEN isNull(H.middleName, '') = '' THEN CONCAT(H.firstName, ' ', H.lastName)
		ELSE CONCAT(H.firstName, ' ', H.middleName, ' ', H.lastName)
	END as name
FROM
	staff.Employee as E
	LEFT JOIN humans.Human as H ON H.id = E.humanId
)

SELECT 
	name as 'value',
	name as 'label',
	id as id
FROM
	tempTable