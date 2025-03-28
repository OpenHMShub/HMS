SELECT la.locationAlias as alias, la.locationName
from  participant.EventLocationsAliases la,  participant.EventLocations l
WHERE  l.name = la.locationName
AND 
(:locationId IS NULL OR  :locationId = -1 OR  :locationId = '' OR l.id = :locationId )
order by la.id