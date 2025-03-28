SELECT distinct
p.id AS 'participantId', 
p.humanId AS 'humanId',
h.first_name as 'firstName',
h.middle_name as 'middleName',
h.last_name as 'lastName',
h.dob AS 'dob',
(SELECT STRING_AGG(programId, ',') FROM participant.Enrollments WHERE particpantId = p.id) as 'enrollments',
p.suspensionActive as 'suspended'
FROM participant.Participant p
INNER JOIN humans.GroupMembership h
ON p.humanId = h.human_id
WHERE 
p.id=:participantID
AND p.timeRetired IS NULL