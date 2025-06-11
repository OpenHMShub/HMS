---Shelter/Reservations/ReservationDetailsPerShelter---
SELECT distinct x.*, coalesce(y.waitListName, '') as waitListName
from
(
SELECT concat (h.firstName , ' ', h.middleName , ' ' , h.lastName) as name, res.reservationStart, res.reservationEnd, res.reservationExpiration, res.timeRetired,
b.bedName, res.participantId, res.id, r.id as roomId, r.roomName, b.id as bedId, coalesce(res.notes , '') as notes, h.gender, h.race,datediff(year, h.BirthDate, getdate())  as age
from
lodging.Reservation res, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.Participant p, participant.Dashboard h
where f.id = :facilityID and f.timeRetired is null and p.timeRetired is null 
and res.bedId = b.id 
and b.roomId = r.id and r.facilityId = f.id and res.participantId = p.id
and h.id = p.Id) x
left outer join
(
SELECT w.participant_id ,  w.program_name as waitListName
FROM shelter.WaitListView w, shelter.WaitList wl
WHERE w.waitlist_id = wl.id and wl.dateRemoved is null ) y
on x.participantId = y.participant_id