SELECT id as 'roomId' , roomName as 'roomName'
from lodging.Room
where facilityId = :facilityId
and timeRetired is null 
and
id not in ( 

SELECT table1.roomId
from
(
SELECT Count(id) as TotalBeds, roomId
from lodging.bed 
group by roomId
) table1,
(
select count(b.id) as reservedBeds, b.roomId  as roomId
from lodging.Bed b, lodging.Reservation r 
where b.timeRetired is null and r.timeRetired is null
and b.id = r.bedId 
group by b.roomId 
)table2
where table1.roomId = table2.roomId and table1.TotalBeds = table2.reservedBeds
 
)