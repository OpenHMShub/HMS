---Shelter/WaitList/WaitListDetailSelect---
SELECT name, participantid, program, dateadded,gender,race,age,notes, dateRemoved FROM
	(SELECT h.firstName + ' ' + h.lastName AS name, w.participantid, s.programId as pgId ,w.dateadded, r.raceName as race, g.genderName as gender, datediff(year, h.dob, getdate()) as 'age', w.details AS 'notes', w.dateRemoved
	FROM shelter.WaitList w
	INNER JOIN participant.Participant p ON p.id = w.participantid 
	INNER JOIN humans.Human h ON h.id = p.humanId
	INNER JOIN shelter.WaitListPrograms s on s.id = w.WaitListProgramId
	INNER JOIN humans.race r ON r.id = h.raceId
	INNER JOIN humans.gender g ON g.id = h.genderId
	
	
	
	) t1
INNER JOIN
	(SELECT id as pgId, programName AS 'program'
	FROM interaction.Program x) t2
ON (t1.pgId = t2.pgId)
ORDER BY DateAdded ASC
