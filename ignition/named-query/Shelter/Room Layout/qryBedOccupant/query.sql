---Shelter/Room Layout/qryBedOccupant---
SELECT concat (h.firstName , ' ', h.middleName , ' ' , h.lastName) as name, bl.eventStart,
b.bedName, bl.participantId, bl.id, r.id as roomId, r.roomName, b.id as bedId, h.gender, h.race, datediff(year, dob, getdate())  as age
from
lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.Participant p, humans.Human h
where bl.bedId =  :BedId and f.timeRetired is null and p.timeRetired is null 
and bl.bedId = b.id 
and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
and h.id = p.humanId
and bl.eventEnd is null 
and bl.eventStart <= GETDATE()