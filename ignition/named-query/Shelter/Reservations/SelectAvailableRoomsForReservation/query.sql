SELECT id as 'value' , roomName as 'label'
from lodging.Room
where facilityId = :facilityId
and timeRetired is null
order by roomName