---Shelter/Reservations/ReservationDetailsAllShelters---
SELECT distinct x.*, coalesce(y.waitListName, '') as waitListName
from
(
SELECT f.id as facilityId, f.facilityName, h.name, h.age,h.race,h.gender, res.reservationStart,  coalesce(res.reservationEnd,CURRENT_TIMESTAMP)  as reservationEnd, res.reservationExpiration as reservationExpiration, res.timeRetired as timeRetired,
b.bedName, res.participantId, res.id, r.id as roomId, r.roomName, b.id as bedId, coalesce(res.notes , '') as notes
from
lodging.Reservation res, lodging.Bed b, lodging.Room r, lodging.Facility f,
(SELECT distinct id, concat (firstname,' ',middlename,' ',lastname) as name ,datediff(year, birthdate, getdate())  as age, race,gender from participant.Dashboard) h
where f.timeRetired is null
and res.bedId = b.id 
and b.roomId = r.id and r.facilityId = f.id and res.participantId = h.id
) x
left outer join
(
SELECT w.participant_id ,  w.program_name as waitListName
FROM shelter.WaitListView w, shelter.WaitList wl
WHERE w.waitlist_id = wl.id and wl.dateRemoved is null ) y
on x.participantId = y.participant_id
-- order by x.facilityName