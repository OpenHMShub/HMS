SELECT b.id as 'value' , bedName as 'label'
from lodging.Bed b, lodging.Room r
where 
r.facilityId = :facilityId and r.id = :roomId
and r.timeRetired is null 
and b.timeRetired is null 
and r.id = b.roomId
and b.id not in (
select b1.id 
from lodging.Bed b1, lodging.BedLog r1
where b1.timeRetired is null and r1.eventEnd is null
and b1.id = r1.bedId
)
