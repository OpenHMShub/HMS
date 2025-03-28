SELECT 
      DateAdd(DAY,s.dayOfYear,DateFromParts(Year(GetDate())-1,12,31)) as DateFromDayOfYear
      ,l.locationName 
	  ,s.locationId
  FROM [shelter].[ScheduleParticipant] s,
  participant.Dashboard d, shelter.Location l 
  WHERE s.timeRetired is NULL AND s.participantId = d.id AND s.locationId = l.id
  AND s.seasonId =  :seasonId  and s.participantId =  :participantId 
  AND ( :congregationName IS NULL or l.locationName  LIKE  :congregationName )
  order by dayOfYear