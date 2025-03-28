SELECT 
	e.[id]
	,e.[locationId]
	,l.location as 'location'
	,e.[eventId]
	,e.[timeCreated]
FROM 
	[participant].[EventSelectedLocations] e
LEFT JOIN
	(SELECT [id] ,[name] as 'location' FROM [participant].[EventLocations]) l on e.locationId = l.id
WHERE
	e.[eventId] = :EventId