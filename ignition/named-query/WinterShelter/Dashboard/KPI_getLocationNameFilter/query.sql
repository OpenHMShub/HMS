select ls.locationId as 'id',
	loc.locationName as 'name',
	nights,
	beds
	--Avg(ls.beds) as 'average beds' 
from
shelter.LocationSeasonal ls
left join shelter.location loc on  loc.id = ls.locationId
where seasonId = :seasonId
and {location}
--group by seasonId
--ls.locationName like '%ack%'