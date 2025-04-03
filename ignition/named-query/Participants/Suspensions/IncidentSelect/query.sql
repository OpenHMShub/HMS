---Participants/Suspensions/IncidentSelect---
SELECT 
	id, incidentDescription
FROM  
	participant.IncidentLog 
WHERE
	 participant.IncidentLog.ParticipantID =  :participant_id 