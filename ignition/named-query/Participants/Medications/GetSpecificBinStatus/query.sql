SELECT TOP 1 *
FROM participant.MedicationBinsLog 
WHERE
	location = :location
		AND
	bin = :bin
		AND
	exitAction IS NULL

ORDER BY
	-- TODO: Check if this should be sorting on createdOn or startOn
	createdOn DESC