SELECT e.[id]
      ,e.[categoryId]
      ,e_cat.[category] as 'category'
      ,e.[name]
      ,e.[startsOn]
      ,e.[endsOn]
      ,e.[allDayEvent]
      ,e.[description]
      ,e.[repeatFrequencyTypeId]
      ,e.[dateSelectionPattern]
      ,e.[dateSelectionDays]
      ,e.[timeCreated]
      ,e.[timeRetired]
      ,e.[points]
      ,e.duration_hours
      ,e.locationId
FROM [participant].[Events] e
LEFT JOIN (select id, name as 'category' FROM[participant].[EventCategories]) e_cat on e.[categoryId] = e_cat.id
WHERE [name] like  '%'+ :eventName +'%' and :eventName IS NOT NULL and :eventName != ''
AND e.timeRetired is NULL