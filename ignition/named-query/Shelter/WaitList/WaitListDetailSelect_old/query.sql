---Shelter/WaitList/WaitListDetailSelect---
SELECT w.wlid, h.firstName + ' ' + h.lastName AS 'Name', x.programName, w.details, w.dateadded 
FROM shelter.WaitList w
INNER JOIN participant.Participant p ON p.id = w.participantid 
INNER JOIN humans.Human h ON h.id = p.humanId 
INNER JOIN interaction.Program x on x.id = w.programid
WHERE w.programid IN (SELECT associatedProgramID FROM lodging.FacilityAssociatedPrograms WHERE facilityId = :FacilityID) AND w.dateremoved IS NULL
ORDER BY w.dateadded ASC