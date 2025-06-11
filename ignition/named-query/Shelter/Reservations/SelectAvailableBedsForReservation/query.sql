SELECT b.id as 'value' , bedName as 'label'
from lodging.Bed b, lodging.Room r
where 
r.facilityId = :facilityId and r.id = :roomId
and r.timeRetired is null 
and b.timeRetired is null 
and r.id = b.roomId
order by bedName