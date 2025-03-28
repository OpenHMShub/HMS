select t1.totalBeds, t2.totalRequested
from
( select sum(capacity) as totalBeds 
	from shelter.Location
	where timeRetired is null
) as t1,
(
select coalesce(sum(beds), 0) as totalRequested
	from shelter.Schedule
	where timeRetired is null and (scheduleEnd >= GETDATE())
) as t2