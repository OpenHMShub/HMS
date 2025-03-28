SELECT TOP 200
	Id,
	Name
FROM
	humans.Medications
WHERE
	(:filter <> '' AND :filter <> '%' AND :filter <> '%%')
		AND
	Name LIKE :filter
		AND
	timeRetired is NULL
		AND
	Name NOT IN ({excludeCSV})