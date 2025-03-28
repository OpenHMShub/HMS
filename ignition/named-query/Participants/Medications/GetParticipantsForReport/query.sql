SELECT
	m.participantId, CONCAT(d.FirstName , ' ' , d.middleName, ' ' , d.lastName ) as participantName
FROM participant.MedicationBinsLog m 
INNER JOIN participant.Dashboard d ON m.participantId = d.ID
WHERE m.exitAction IS NULL AND m.location in ('Guest House Bin', 'Black Box', 'Guest House Fridge')