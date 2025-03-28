SELECT l.id, l.name, l.id as arrowUp, l.id as arrowDown
FROM participant.EventLocations l,
participant.EventLocationsAliases la
WHERE la.locationName = l.name
AND l.name like '%' +  :Location_Name  + '%' or :Location_Name is NULL
ORDER by CAST(substring(la.locationAlias, 4,len(la.locationAlias)) AS INT)

