---Shelter/ParticipantView/BedLog---
SELECT 
	b.id as 'bedId',bl.eventStart as 'CheckIn',bl.eventEnd as 'CheckOut',
	b.bedName as 'Bed',h.firstName +' '+h.lastName as 'Participant' 
FROM 
	lodging.BedLog bl 
	LEFT JOIN participant.Participant p on p.id = bl.participantId
	LEFT JOIN humans.Human h on h.id = p.humanId
	LEFT JOIN lodging.Bed b on b.id = bl.bedId
WHERE 
	bl.participantId = :participantId
	AND (
		(bl.eventStart BETWEEN :timeBegin AND :timeEnd)
		OR
		(bl.eventEnd BETWEEN :timeBegin AND :timeEnd)
		)