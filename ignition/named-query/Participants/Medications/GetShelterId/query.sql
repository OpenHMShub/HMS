SELECT 
	COALESCE(shelterId , -1)  as shelterId
FROM
	participant.Dashboard
WHERE
	ID = :Participant_Id
		