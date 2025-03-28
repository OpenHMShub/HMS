SELECT
	p.FirstName AS "First Name",
	p.MiddleName AS "Middle Name",
	p.LastName AS "Last Name",
	CONCAT_WS(' ', p.FirstName, p.MiddleName, p.LastName) AS "Name",
	p.Suspension AS "Is Suspended",
	CAST(CASE WHEN 
		s.room_id IS NOT NULL AND 
		(s.last_check_out IS NULL OR 
			s.last_check_out > GETDATE())
		THEN 1 ELSE 0 END AS BIT) AS "Has Shelter"
FROM participant.Dashboard AS p
LEFT JOIN participant.CurrentShelter AS s ON s.participant_id = p.ID
WHERE p.ID = :participantId