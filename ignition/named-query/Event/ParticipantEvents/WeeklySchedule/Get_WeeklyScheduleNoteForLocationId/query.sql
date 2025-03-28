SELECT n.[id]
      ,n.[time]
      ,n.[date]
      ,n.[locationId]
      ,n.[note]
      ,n.[timeCreated]
  FROM [participant].[EventWeeklyScheduleNote] n
  LEFT JOIN participant.EventLocations e on n.locationId = e.id
  WHERE e.id = :locationId
  AND n.date = :Time