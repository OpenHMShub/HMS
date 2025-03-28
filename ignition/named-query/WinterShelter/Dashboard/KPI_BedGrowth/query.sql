select beds
from
shelter.LocationSeasonal
where seasonId = :seasonId
and locationId
order by nights asc