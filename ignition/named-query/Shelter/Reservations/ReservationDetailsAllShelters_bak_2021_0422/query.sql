---Shelter/Reservations/ReservationDetailsAllShelters---
IF :activeFilter = '-1' 
BEGIN
SELECT f.id as facilityId, f.facilityName, h.name, h.age,h.race,h.gender, res.reservationStart,  coalesce(res.reservationEnd,CURRENT_TIMESTAMP)  as reservationEnd, res.reservationExpiration as reservationExpiration, res.timeRetired as timeRetired,
b.bedName, res.participantId, res.id, r.id as roomId, r.roomName, b.id as bedId, coalesce(res.notes , '') as notes, COALESCE(res.waitingListName,'All Waiting Lists') as waitListName, COALESCE(res.programId, -1) as programId, COALESCE(res.providerId, -1) as providerId, COALESCE(res.providerTypeId, -1) as providerTypeId, COALESCE(res.referralStatus, '') as referralStatus, COALESCE(res.reservationType, '') as reservationType
from
lodging.Reservation res, lodging.Bed b, lodging.Room r, lodging.Facility f,
(SELECT distinct id, concat (firstname,' ',middlename,' ',lastname) as name ,datediff(year, birthdate, getdate())  as age, race,gender from participant.Dashboard) h
where f.timeRetired is null
and res.bedId = b.id 
and b.roomId = r.id and r.facilityId = f.id and res.participantId = h.id
and (res.reservationExpiration is null and res.timeRetired is null)
END

IF :activeFilter = 'Inactive' 
BEGIN
SELECT f.id as facilityId, f.facilityName, h.name, h.age,h.race,h.gender, res.reservationStart,  coalesce(res.reservationEnd,CURRENT_TIMESTAMP)  as reservationEnd, res.reservationExpiration as reservationExpiration, res.timeRetired as timeRetired,
b.bedName, res.participantId, res.id, r.id as roomId, r.roomName, b.id as bedId, coalesce(res.notes , '') as notes, COALESCE(res.waitingListName,'All Waiting Lists') as waitListName, COALESCE(res.programId, -1) as programId, COALESCE(res.providerId, -1) as providerId, COALESCE(res.providerTypeId, -1) as providerTypeId, COALESCE(res.referralStatus, '') as referralStatus, COALESCE(res.reservationType, '') as reservationType
from
lodging.Reservation res, lodging.Bed b, lodging.Room r, lodging.Facility f,
(SELECT distinct id, concat (firstname,' ',middlename,' ',lastname) as name ,datediff(year, birthdate, getdate())  as age, race,gender from participant.Dashboard) h
where f.timeRetired is null
and res.bedId = b.id 
and b.roomId = r.id and r.facilityId = f.id and res.participantId = h.id
and (res.reservationExpiration is null or res.timeRetired is null)
END

IF :activeFilter = 'All' 
BEGIN
SELECT f.id as facilityId, f.facilityName, h.name, h.age,h.race,h.gender, res.reservationStart,  coalesce(res.reservationEnd,CURRENT_TIMESTAMP)  as reservationEnd, res.reservationExpiration as reservationExpiration, res.timeRetired as timeRetired,
b.bedName, res.participantId, res.id, r.id as roomId, r.roomName, b.id as bedId, coalesce(res.notes , '') as notes, COALESCE(res.waitingListName,'All Waiting Lists') as waitListName, COALESCE(res.programId, -1) as programId, COALESCE(res.providerId, -1) as providerId, COALESCE(res.providerTypeId, -1) as providerTypeId, COALESCE(res.referralStatus, '') as referralStatus, COALESCE(res.reservationType, '') as reservationType
from
lodging.Reservation res, lodging.Bed b, lodging.Room r, lodging.Facility f,
(SELECT distinct id, concat (firstname,' ',middlename,' ',lastname) as name ,datediff(year, birthdate, getdate())  as age, race,gender from participant.Dashboard) h
where f.timeRetired is null
and res.bedId = b.id 
and b.roomId = r.id and r.facilityId = f.id and res.participantId = h.id
END
