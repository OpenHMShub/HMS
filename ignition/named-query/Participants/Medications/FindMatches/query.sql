/*---Participants/Registration/FindMatches---*/

SELECT TOP 25 
	p.id AS 'participantId', 
	p.humanId AS 'humanId',
	h.firstName as 'firstName',
	h.middleName as 'middleName',
	h.lastName as 'lastName',
	DATEADD(hh,12,CAST(h.dob as DATETIME)) as 'dob',
	--h.dob AS 'dob'
	p.suspensionActive AS 'suspensionActive'
FROM
	participant.Participant p
		INNER JOIN
	humans.Human h ON p.humanId = h.id
WHERE
	( :firstName is null OR h.firstName is null OR h.firstName LIKE '%'+ :firstName+'%')
AND
( :middleName is null OR h.middleName is null OR h.middleName LIKE '%'+ :middleName+'%')
AND
( :lastName is null OR h.lastName is null OR h.lastName LIKE '%'+ :lastName+'%')
AND 
p.timeRetired IS NULL
AND
((:currentOnly = 1 AND p.id in (select participantId from lodging.bedLog where eventEnd is NULL )) OR (:currentOnly = 0))