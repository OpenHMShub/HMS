SELECT sp.participantId , CONCAT(d.firstName, ' ', d.lastName) as participantName, d.BirthDate
FROM shelter.ScheduleParticipant sp, participant.Dashboard d
WHERE sp.participantId = d.id 
AND sp.scheduleId = :scheduleId 
AND sp.locationId =  :locationId  
AND sp.seasonId =  :seasonId  
AND sp.dayOfYear =  :dayOfYear 
AND sp.timeRetired is null
