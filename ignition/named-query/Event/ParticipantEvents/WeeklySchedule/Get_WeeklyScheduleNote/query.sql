SELECT n.[id]
      ,n.[time]
      ,n.[date]
      ,n.[locationId]
      ,n.[note]
      ,n.[timeCreated]
  FROM [participant].[EventWeeklyScheduleNote] n
  LEFT JOIN participant.EventLocations e on n.locationId = e.id
  LEFT JOIN participant.EventLocationsAliases a on a.locationName = e.name
  WHERE a.locationAlias = :location
  AND n.date = :Time