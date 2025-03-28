SELECT  ea.participantId , CONCAT(d.firstName, ' ', d.lastName) as participantName, d.BirthDate
FROM participant.EventAttendance ea, participant.Dashboard d
WHERE 
ea.participantId = d.ID 
AND ea.scheduleId = :scheduleId 
AND ea.timeRetired is null
