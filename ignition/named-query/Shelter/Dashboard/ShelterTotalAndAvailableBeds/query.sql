select t1.totalBeds, 
case 
when t2.totalReservations is null then t1.totalBeds
else t1.totalBeds  - t2.totalReservations
end as availableBeds
from
( select sum(beds) as totalBeds 
from lodging.Facility 
where timeRetired is null
) as t1,
(
select count(bedId) as totalReservations
from lodging.Reservation
where timeRetired is null and (reservationEnd > GETDATE() )
) as t2