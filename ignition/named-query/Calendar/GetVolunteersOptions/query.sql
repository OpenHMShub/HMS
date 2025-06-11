WITH tempTable AS
(
SELECT
	V.id,
	CASE
		WHEN isNull(H.middleName, '') = '' THEN CONCAT(H.firstName, ' ', H.lastName)
		ELSE CONCAT(H.firstName, ' ', H.middleName, ' ', H.lastName)
	END as name
FROM
	staff.Volunteer as V
	LEFT JOIN humans.Human as H ON H.id = V.humanId
)

SELECT 
	name as 'value',
	name as 'label',
	id as id
FROM
	tempTable