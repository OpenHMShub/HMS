---Shelter/ParticipantView/Reservation---
SELECT 
	b.id as 'bedId',r.reservationStart as 'CheckIn',r.reservationEnd as 'CheckOut',
	r.timeCreated as 'ReservedDate',b.bedName as 'Bed',h.firstName +' '+h.lastName as 'Participant' 
FROM 
	lodging.Reservation r 
	LEFT JOIN participant.Participant p on p.id = r.participantId
	LEFT JOIN humans.Human h on h.id = p.humanId
	LEFT JOIN lodging.Bed b on b.id = r.bedId
WHERE 
	r.timeRetired IS NULL
	AND r.participantId = :participantId
	AND (
		(r.reservationStart BETWEEN :timeBegin AND :timeEnd)
		OR
		(r.reservationEnd BETWEEN :timeBegin AND :timeEnd)
		)