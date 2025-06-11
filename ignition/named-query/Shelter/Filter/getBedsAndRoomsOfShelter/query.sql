SELECT roomId, roomName, b.id as bedId, bedName 
from lodging.Bed b, lodging.Room r
where 
r.facilityId = :facilityId and r.id = b.roomId
and r.timeRetired is null 
and b.timeRetired is null 