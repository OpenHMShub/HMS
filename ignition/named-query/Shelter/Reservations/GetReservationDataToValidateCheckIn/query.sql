SELECT x.* , p.programName FROM
(
SELECT f.facilityName
,h.gender
,res.reservationStart
,coalesce(res.reservationEnd,CURRENT_TIMESTAMP) as reservationEnd
,res.reservationExpiration as reservationExpiration
,res.timeRetired as timeRetired
,b.bedName
,r.gender as roomGender
,COALESCE(res.programId, -1) as programId
,b.id as bedId
,h.age
from
lodging.Reservation res, lodging.Bed b, lodging.Room r, lodging.Facility f,
(SELECT distinct id
	,concat (firstname,' ',middlename,' ',lastname) as name
	,datediff(year, birthdate, getdate()) as age
	,race,gender from participant.Dashboard) h
where res.id = :reservationId and f.timeRetired is null
and res.bedId = b.id 
and b.roomId = r.id and r.facilityId = f.id and res.participantId = h.id
and b.id not in ( select distinct bedId FROM lodging.bedLog where eventEnd is NULL)
) x
LEFT JOIN
interaction.Program p ON x.programId = p.id