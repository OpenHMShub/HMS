---Shelter/BedView/BedStatusPerRoom---
SELECT 
	--b.id as 'bedId', b.roomId, rm.facilityId, 
	convert(nvarchar,bl.eventStart,1) as 'Check In',convert(nvarchar,bl.eventEnd,1) as 'Check Out',
	convert(nvarchar,r.reservationStart,1) as 'Reserved From', convert(nvarchar,r.reservationEnd,1) as 'Reserved To',
	convert(nvarchar,r.timeCreated,1) as 'Reserved Date',b.id,b.roomID, b.bedName as 'Bed',h.firstName +' '+h.lastName as 'Participant', left(h.gender,1) as 'gender'
	,case when r.reservationStart is null or (r.reservationStart is not null and r.reservationEnd is not null) then 0 else 1 end as 'Reserved'
	,case when bl.eventStart is null or (bl.eventStart is not null and bl.eventEnd is not null) then 0 else 1 end as 'Occupied'
FROM 
	lodging.BedLog bl 
	LEFT JOIN participant.Participant p on p.id = bl.participantId
	LEFT JOIN humans.Human h on h.id = p.humanId
	LEFT JOIN lodging.Bed b on b.id = bl.bedId
	LEFT JOIN lodging.reservation r on r.bedId = b.id
	left join lodging.room rm on rm.id = b.roomID
	
	WHERE	rm.Id =  :RoomID 
AND 
(
		(bl.eventStart BETWEEN :DateStart AND :DateEnd)
		OR
		(bl.eventEnd BETWEEN :DateStart AND :DateEnd)
		)
