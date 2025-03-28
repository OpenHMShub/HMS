SELECT COUNT(DISTINCT participantId)
FROM
(
SELECT sp.participantId 
FROM shelter.ScheduleParticipant sp, participant.Dashboard d
WHERE sp.participantId = d.id
AND sp.seasonId =  :seasonId  
AND sp.timeRetired is null ) x


