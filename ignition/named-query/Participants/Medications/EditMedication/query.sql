UPDATE
	humans.Medications
SET
	actor = :actor,
	name = :name_new
WHERE
	name = :name_old