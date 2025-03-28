---Shelter/Reservations/ReservationDetailsPerShelter---
SELECT concat (h.firstName , ' ', h.middleName , ' ' , h.lastName) as name, res.reservationStart, res.reservationEnd, res.reservationExpiration, res.timeRetired,
b.bedName, res.participantId, res.id, r.id as roomId, r.roomName, b.id as bedId, coalesce(res.notes , '') as notes, h.gender, h.race,datediff(year, h.BirthDate, getdate())  as age, COALESCE(res.waitingListName,'All Waiting Lists') as waitListName, COALESCE(res.programId, -1) as programId, COALESCE(res.providerId, -1) as providerId, COALESCE(res.providerTypeId, -1) as providerTypeId, COALESCE(res.referralStatus, '') as referralStatus, COALESCE(res.reservationType, '') as reservationType
from
lodging.Reservation res, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.Participant p, participant.Dashboard h
where f.id = :facilityID and f.timeRetired is null and p.timeRetired is null 
and res.bedId = b.id 
and b.roomId = r.id and r.facilityId = f.id and res.participantId = p.id
and h.id = p.Id
order by res.reservationStart desc