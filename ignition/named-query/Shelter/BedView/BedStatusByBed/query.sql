---Shelter/BedView/BedStatusByBed---
SELECT 
	b.id as 'bedId', b.roomId, rm.facilityId, bl.eventStart as 'CheckIn',bl.eventEnd as 'CheckOut',
	r.reservationStart as 'ResIn',r.reservationEnd as 'ResOut',
	r.timeCreated as 'ReservedDate',b.bedName as 'Bed',h.firstName +' '+h.lastName as 'Participant', left(h.gender,1) as 'gender'
	,case when r.reservationStart is null or (r.reservationStart is not null and r.reservationEnd is not null) then 0 else 1 end as 'Reserved'
	,case when bl.eventStart is null or (bl.eventStart is not null and bl.eventEnd is not null) then 0 else 1 end as 'Occupied', p.id as 'ParticID'
FROM 
	lodging.BedLog bl 
	LEFT JOIN participant.Participant p on p.id = bl.participantId
	LEFT JOIN humans.Human h on h.id = p.humanId
	LEFT JOIN lodging.Bed b on b.id = bl.bedId
	LEFT JOIN lodging.reservation r on r.bedId = b.id
	left join lodging.room rm on rm.id = b.roomID
WHERE
	b.Id =   :BedID 