---Shelter/CurrentResidents/CurrentResidentsPerShelter_old---
SELECT concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd,
b.bedName, bl.participantId, bl.id, r.id as roomId, r.roomName, b.id as bedId, p.gender, p.race, datediff(year, BirthDate, getdate())  as age
from
lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.Dashboard p
where f.id = :facilityID and f.timeRetired is null 
and bl.bedId = b.id 
and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
and bl.eventStart <= GETDATE()