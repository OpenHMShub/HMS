/*---Participants/Services/BatchServices/FindParticipants---*/

SELECT TOP 25 
	p.id AS 'participantId', 
	p.humanId AS 'humanId',
	h.first_name as 'firstName',
	h.middle_name as 'middleName',
	h.last_name as 'lastName',
	h.dob AS 'dob'
FROM 
	participant.Participant p
	INNER JOIN humans.GroupMembership h ON p.humanId = h.human_id
WHERE 
	(h.first_name LIKE '%'+ISNULL(:firstName,h.first_name)+'%') AND
	(h.middle_name LIKE '%'+ISNULL(:middleName,h.middle_name)+'%') AND
	(h.last_name LIKE '%'+ISNULL(:lastName,h.last_name)+'%')
	
	AND p.timeRetired IS NULL