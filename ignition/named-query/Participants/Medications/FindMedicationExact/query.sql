SELECT
	Id,
	Name,
	timeRetired
FROM
	humans.Medications
WHERE
	Name = :name
		AND
	timeRetired is NULL