---Shelter/BedView/ReservationBedLog---
SELECT 
	b.id as 'bedId',b.roomId,bl.eventStart as 'CheckIn',bl.eventEnd as 'CheckOut',
	b.bedName as 'Bed',h.firstName +' '+h.lastName as 'Participant', 0 as 'isReservation' 
FROM 
	lodging.BedLog bl 
	LEFT JOIN participant.Participant p on p.id = bl.participantId
	LEFT JOIN humans.Human h on h.id = p.humanId
	LEFT JOIN lodging.Bed b on b.id = bl.bedId
WHERE 
	bl.bedId = :bedId
	AND (
		(bl.eventStart BETWEEN :timeBegin AND :timeEnd)
		OR
		(bl.eventEnd BETWEEN :timeBegin AND :timeEnd)
		)

UNION

SELECT 
	b.id as 'bedId',b.roomId,r.reservationStart as 'CheckIn',r.reservationEnd as 'CheckOut',
	b.bedName as 'Bed',h.firstName +' '+h.lastName as 'Participant', 1 as 'isReservation'
FROM 
	lodging.Reservation r 
	LEFT JOIN participant.Participant p on p.id = r.participantId
	LEFT JOIN humans.Human h on h.id = p.humanId
	LEFT JOIN lodging.Bed b on b.id = r.bedId
WHERE 
	r.timeRetired IS NULL
	AND r.bedId = :bedId
	AND (
		(r.reservationStart BETWEEN :timeBegin AND :timeEnd)
		OR
		(r.reservationEnd BETWEEN :timeBegin AND :timeEnd)
		)