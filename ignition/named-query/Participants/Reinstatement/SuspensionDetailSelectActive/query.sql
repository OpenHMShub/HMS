---Participants/Reinstatement/SuspensionDetailSelectActive---

SELECT
	s.id
	
FROM
	[participant].[SuspensionDashboard] s

WHERE
	s.participantId =  :participant_id 
	AND s.dateReinstated is null
