DECLARE @date VARCHAR(200) = :date --'2023-06-02'
DECLARE @locationId int = :locationId
DECLARE @facilitatorId int = :facilitatorId
DECLARE @categoryId int = :categoryId
DECLARE @eventName VARCHAR(200) = :eventName
DECLARE @location_list varchar(max),@location_list1 varchar(max), @query varchar(max) 
set @location_list = '['+ (STUFF((SELECT distinct ',[' + name + ']'from participant.EventLocations where id = @locationId or @locationId = '' or ISNULL(@locationId,-1) = -1  
							FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,2,'') )
set @location_list1 = 'I'+ (STUFF((SELECT distinct ',ISNULL([' + name + '],'' '') as ''' + name + ''''from participant.EventLocations where id = @locationId or @locationId = '' or ISNULL(@locationId,-1) = -1 
							FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,2,'') )

exec('SELECT 1 AS ''id'',concat(''' + @date + ''','' 07:00:00'') AS ''date'',''''As ''Day'', [TIME], ' + @location_list1 +' 
				FROM (
				  SELECT ''7:00A'' AS ''TIME'',
						  CASE WHEN COUNT(1) > 0 THEN max(a.location) ELSE '' '' END AS location, 
						  CASE WHEN COUNT(1) > 0 THEN max(a.EventName) ELSE '' '' END AS EventName
				  FROM 
						(SELECT 
						l.name AS ''location'',
						concat(e.name,''-color-'',ISNULL(c.color, ''None'')) AS ''EventName''
						FROM participant.EventLocations l
						LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
						LEFT JOIN participant.Events e on s.[eventId] = e.id
						LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
						
						WHERE (s.[locationId] = ''' + @locationId + ''' OR ''' + @locationId + ''' = NULL OR ''' + @locationId + ''' = '''' OR ''' + @locationId + ''' = -1 )
							AND (e.[facilitatorEmployeeId] = ''' + @facilitatorId + ''' OR ''' + @facilitatorId + ''' = NULL OR ''' + @facilitatorId + ''' = '''' OR ''' + @facilitatorId + ''' = -1)
							AND (e.[categoryId] = ''' + @categoryId + ''' OR ''' + @categoryId + ''' = NULL OR ''' + @categoryId + ''' = '''' OR ''' + @categoryId + ''' = -1)
							AND ( e.[name] = ''' + @eventName + ''' OR ''' + @eventName + ''' = NULL OR ''' + @eventName + ''' = '''')							
							AND (s.[startsOn] between concat(''' + @date + ''','' 07:00:00'') and concat(''' + @date + ''','' 07:29:59'')) 
							
						) a
				  ) x
				  PIVOT (max(EventName) FOR location IN (' + @location_list +')
				) t1
				UNION
				SELECT 2 AS ''id'',concat(''' + @date + ''','' 07:30:00'') AS ''date'',''''As ''Day'', [TIME], ' + @location_list1 +' 
				FROM (
				  SELECT ''7:30A'' AS ''TIME'',
						CASE WHEN COUNT(1) > 0 THEN max(a.location) ELSE '' '' END AS location, 
						CASE WHEN COUNT(1) > 0 THEN max(a.EventName) ELSE '' '' END AS EventName
				  FROM 
						(SELECT 
						l.name AS ''location'',
						concat(e.name,''-color-'',ISNULL(c.color, ''None'')) AS ''EventName''
						FROM participant.EventLocations l
						LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
						LEFT JOIN participant.Events e on s.[eventId] = e.id 
						LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
						
						WHERE (s.[locationId] = ''' + @locationId + ''' OR ''' + @locationId + ''' = NULL OR ''' + @locationId + ''' = '''' OR ''' + @locationId + ''' = -1 )
							AND (e.[facilitatorEmployeeId] = ''' + @facilitatorId + ''' OR ''' + @facilitatorId + ''' = NULL OR ''' + @facilitatorId + ''' = '''' OR ''' + @facilitatorId + ''' = -1)
							AND (e.[categoryId] = ''' + @categoryId + ''' OR ''' + @categoryId + ''' = NULL OR ''' + @categoryId + ''' = '''' OR ''' + @categoryId + ''' = -1)
							AND ( e.[name] = ''' + @eventName + ''' OR ''' + @eventName + ''' = NULL OR ''' + @eventName + ''' = '''')					
							AND (s.[startsOn] between concat(''' + @date + ''','' 07:30:00'') and concat(''' + @date + ''','' 07:59:59'')) 
							
						) a
				  ) x
				  PIVOT (max(EventName) FOR location IN (' + @location_list +')
				) t2
				UNION
				SELECT 3 AS ''id'',concat(''' + @date + ''','' 08:00:00'') AS ''date'',''''As ''Day'', [TIME], ' + @location_list1 +' 
				FROM (
				  SELECT ''8:00A'' AS ''TIME'',
						  CASE WHEN COUNT(1) > 0 THEN max(a.location) ELSE '' '' END AS location, 
						  CASE WHEN COUNT(1) > 0 THEN max(a.EventName) ELSE '' '' END AS EventName
				  FROM 
						(SELECT 
						l.name AS ''location'',
						concat(e.name,''-color-'',ISNULL(c.color, ''None'')) AS ''EventName''
						FROM participant.EventLocations l
						LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
						LEFT JOIN participant.Events e on s.[eventId] = e.id
						LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
						
						WHERE (s.[locationId] = ''' + @locationId + ''' OR ''' + @locationId + ''' = NULL OR ''' + @locationId + ''' = '''' OR ''' + @locationId + ''' = -1 )
							AND (e.[facilitatorEmployeeId] = ''' + @facilitatorId + ''' OR ''' + @facilitatorId + ''' = NULL OR ''' + @facilitatorId + ''' = '''' OR ''' + @facilitatorId + ''' = -1)
							AND (e.[categoryId] = ''' + @categoryId + ''' OR ''' + @categoryId + ''' = NULL OR ''' + @categoryId + ''' = '''' OR ''' + @categoryId + ''' = -1)
							AND ( e.[name] = ''' + @eventName + ''' OR ''' + @eventName + ''' = NULL OR ''' + @eventName + ''' = '''')				
							AND (s.[startsOn] between concat(''' + @date + ''','' 08:00:00'') and concat(''' + @date + ''','' 08:59:59'')) 
							
						) a
				  ) x
				  PIVOT (max(EventName) FOR location IN (' + @location_list +')
				) t3
				UNION
				SELECT 4 AS ''id'',concat(''' + @date + ''','' 09:00:00'') AS ''date'',''''As ''Day'', [TIME], ' + @location_list1 +' 
				FROM (
				  SELECT ''9:00A'' AS ''TIME'', 
						CASE WHEN COUNT(1) > 0 THEN max(a.location) ELSE '' '' END AS location, 
						CASE WHEN COUNT(1) > 0 THEN max(a.EventName) ELSE '' '' END AS EventName
				  FROM 
						(SELECT 
						l.name AS ''location'',
						concat(e.name,''-color-'',ISNULL(c.color, ''None'')) AS ''EventName''
						FROM participant.EventLocations l
						LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
						LEFT JOIN participant.Events e on s.[eventId] = e.id
						LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
						
						WHERE (s.[locationId] = ''' + @locationId + ''' OR ''' + @locationId + ''' = NULL OR ''' + @locationId + ''' = '''' OR ''' + @locationId + ''' = -1 )
							AND (e.[facilitatorEmployeeId] = ''' + @facilitatorId + ''' OR ''' + @facilitatorId + ''' = NULL OR ''' + @facilitatorId + ''' = '''' OR ''' + @facilitatorId + ''' = -1)
							AND (e.[categoryId] = ''' + @categoryId + ''' OR ''' + @categoryId + ''' = NULL OR ''' + @categoryId + ''' = '''' OR ''' + @categoryId + ''' = -1)
							AND ( e.[name] = ''' + @eventName + ''' OR ''' + @eventName + ''' = NULL OR ''' + @eventName + ''' = '''')						
							AND (s.[startsOn] between concat(''' + @date + ''','' 09:00:00'') and concat(''' + @date + ''','' 10:29:59'')) 
							
						) a
				  ) x
				  PIVOT (max(EventName) FOR location IN (' + @location_list +')
				) t4
				UNION
				SELECT 5 AS ''id'',concat(''' + @date + ''','' 10:30:00'') AS ''date'',FORMAT (CAST('''+@date+''' as Date), ''dddd'') As ''Day'', [TIME], ' + @location_list1 +' 
				FROM (
				  SELECT ''10:30A'' AS ''TIME'',
						  CASE WHEN COUNT(1) > 0 THEN max(a.location) ELSE '' '' END AS location, 
						  CASE WHEN COUNT(1) > 0 THEN max(a.EventName) ELSE '' '' END AS EventName
				  FROM 
						(SELECT 
						l.name AS ''location'',
						concat(e.name,''-color-'',ISNULL(c.color, ''None'')) AS ''EventName''
						FROM participant.EventLocations l
						LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
						LEFT JOIN participant.Events e on s.[eventId] = e.id
						LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
						
						WHERE (s.[locationId] = ''' + @locationId + ''' OR ''' + @locationId + ''' = NULL OR ''' + @locationId + ''' = '''' OR ''' + @locationId + ''' = -1 )
							AND (e.[facilitatorEmployeeId] = ''' + @facilitatorId + ''' OR ''' + @facilitatorId + ''' = NULL OR ''' + @facilitatorId + ''' = '''' OR ''' + @facilitatorId + ''' = -1)
							AND (e.[categoryId] = ''' + @categoryId + ''' OR ''' + @categoryId + ''' = NULL OR ''' + @categoryId + ''' = '''' OR ''' + @categoryId + ''' = -1)
							AND ( e.[name] = ''' + @eventName + ''' OR ''' + @eventName + ''' = NULL OR ''' + @eventName + ''' = '''')					
							AND (s.[startsOn] between concat(''' + @date + ''','' 10:30:00'') and concat(''' + @date + ''','' 13:14:59'')) 
							
						) a
				  ) x
				  PIVOT (max(EventName) FOR location IN (' + @location_list +')
				) t5
				UNION
				SELECT 6 AS ''id'',concat(''' + @date + ''','' 13:15:00'') AS ''date'',FORMAT (CAST('''+@date+''' as Date), ''M/dd'') As ''Day'', [TIME], ' + @location_list1 +' 
				FROM (
				  SELECT ''1:15P'' AS ''TIME'',
						CASE WHEN COUNT(1) > 0 THEN max(a.location) ELSE '' '' END AS location, 
						CASE WHEN COUNT(1) > 0 THEN max(a.EventName) ELSE '' '' END AS EventName
				  FROM 
						(SELECT 
						l.name AS ''location'',
						concat(e.name,''-color-'',ISNULL(c.color, ''None'')) AS ''EventName''
						FROM participant.EventLocations l
						LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
						LEFT JOIN participant.Events e on s.[eventId] = e.id
						LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
						
						WHERE (s.[locationId] = ''' + @locationId + ''' OR ''' + @locationId + ''' = NULL OR ''' + @locationId + ''' = '''' OR ''' + @locationId + ''' = -1 )
							AND (e.[facilitatorEmployeeId] = ''' + @facilitatorId + ''' OR ''' + @facilitatorId + ''' = NULL OR ''' + @facilitatorId + ''' = '''' OR ''' + @facilitatorId + ''' = -1)
							AND (e.[categoryId] = ''' + @categoryId + ''' OR ''' + @categoryId + ''' = NULL OR ''' + @categoryId + ''' = '''' OR ''' + @categoryId + ''' = -1)
							AND ( e.[name] = ''' + @eventName + ''' OR ''' + @eventName + ''' = NULL OR ''' + @eventName + ''' = '''')					
							AND (s.[startsOn] between concat(''' + @date + ''','' 13:15:00'') and concat(''' + @date + ''','' 14:29:59'')) 
							
						) a
				  ) x
				  PIVOT (max(EventName) FOR location IN (' + @location_list +')
				) t6
				UNION
				SELECT 7 AS ''id'',concat(''' + @date + ''','' 14:30:00'') AS ''date'',''''As ''Day'', [TIME], ' + @location_list1 +' 
				FROM (
				  SELECT ''2:30P(GH)'' AS ''TIME'',
						  CASE WHEN COUNT(1) > 0 THEN max(a.location) ELSE '' '' END AS location, 
						  CASE WHEN COUNT(1) > 0 THEN max(a.EventName) ELSE '' '' END AS EventName
				  FROM 
						(SELECT 
						l.name AS ''location'',
						concat(e.name,''-color-'',ISNULL(c.color, ''None'')) AS ''EventName''
						FROM participant.EventLocations l
						LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
						LEFT JOIN participant.Events e on s.[eventId] = e.id
						LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
						
						WHERE (s.[locationId] = ''' + @locationId + ''' OR ''' + @locationId + ''' = NULL OR ''' + @locationId + ''' = '''' OR ''' + @locationId + ''' = -1 )
							AND (e.[facilitatorEmployeeId] = ''' + @facilitatorId + ''' OR ''' + @facilitatorId + ''' = NULL OR ''' + @facilitatorId + ''' = '''' OR ''' + @facilitatorId + ''' = -1)
							AND (e.[categoryId] = ''' + @categoryId + ''' OR ''' + @categoryId + ''' = NULL OR ''' + @categoryId + ''' = '''' OR ''' + @categoryId + ''' = -1)
							AND ( e.[name] = ''' + @eventName + ''' OR ''' + @eventName + ''' = NULL OR ''' + @eventName + ''' = '''')					
							AND (s.[startsOn] between concat(''' + @date + ''','' 14:30:00'') and concat(''' + @date + ''','' 15:29:59'')) 
							
						) a
				  ) x
				  PIVOT (max(EventName) FOR location IN (' + @location_list +')
				) t7
				UNION
				SELECT 8 AS ''id'',concat(''' + @date + ''','' 15:30:00'') AS ''date'',''''As ''Day'', [TIME], ' + @location_list1 +' 
				FROM (
				  SELECT ''3:30P(GH)'' AS ''TIME'',
						  CASE WHEN COUNT(1) > 0 THEN max(a.location) ELSE '' '' END AS location, 
						  CASE WHEN COUNT(1) > 0 THEN max(a.EventName) ELSE '' '' END AS EventName
				  FROM 
						(SELECT 
						l.name AS ''location'',
						concat(e.name,''-color-'',ISNULL(c.color, ''None'')) AS ''EventName''
						FROM participant.EventLocations l
						LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
						LEFT JOIN participant.Events e on s.[eventId] = e.id
						LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
						
						WHERE (s.[locationId] = ''' + @locationId + ''' OR ''' + @locationId + ''' = NULL OR ''' + @locationId + ''' = '''' OR ''' + @locationId + ''' = -1 )
							AND (e.[facilitatorEmployeeId] = ''' + @facilitatorId + ''' OR ''' + @facilitatorId + ''' = NULL OR ''' + @facilitatorId + ''' = '''' OR ''' + @facilitatorId + ''' = -1)
							AND (e.[categoryId] = ''' + @categoryId + ''' OR ''' + @categoryId + ''' = NULL OR ''' + @categoryId + ''' = '''' OR ''' + @categoryId + ''' = -1)
							AND ( e.[name] = ''' + @eventName + ''' OR ''' + @eventName + ''' = NULL OR ''' + @eventName + ''' = '''')					
							AND (s.[startsOn] between concat(''' + @date + ''','' 15:30:00'') and concat(''' + @date + ''','' 15:59:59'')) 
							
						) a
				  ) x
				  PIVOT (max(EventName) FOR location IN (' + @location_list +')
				) t8
				UNION
				SELECT 9 AS ''id'',concat(''' + @date + ''','' 18:00:00'') AS ''date'',''''As ''Day'', [TIME], ' + @location_list1 +' 
				FROM (
				  SELECT ''GH Evening'' AS ''TIME'',
						  CASE WHEN COUNT(1) > 0 THEN max(a.location) ELSE '' '' END AS location, 
						  CASE WHEN COUNT(1) > 0 THEN max(a.EventName) ELSE '' '' END AS EventName
				  FROM 
						(SELECT 
						l.name AS ''location'',
						concat(e.name,''-color-'',ISNULL(c.color, ''None'')) AS ''EventName''
						FROM participant.EventLocations l
						LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
						LEFT JOIN participant.Events e on s.[eventId] = e.id
						LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
						
						WHERE (s.[locationId] = ''' + @locationId + ''' OR ''' + @locationId + ''' = NULL OR ''' + @locationId + ''' = '''' OR ''' + @locationId + ''' = -1 )
							AND (e.[facilitatorEmployeeId] = ''' + @facilitatorId + ''' OR ''' + @facilitatorId + ''' = NULL OR ''' + @facilitatorId + ''' = '''' OR ''' + @facilitatorId + ''' = -1)
							AND (e.[categoryId] = ''' + @categoryId + ''' OR ''' + @categoryId + ''' = NULL OR ''' + @categoryId + ''' = '''' OR ''' + @categoryId + ''' = -1)
							AND ( e.[name] = ''' + @eventName + ''' OR ''' + @eventName + ''' = NULL OR ''' + @eventName + ''' = '''')					
							AND (s.[startsOn] between concat(''' + @date + ''','' 16:00:00'') and concat(''' + @date + ''','' 23:59:59'')) 
							
						) a
				  ) x
				  PIVOT (max(EventName) FOR location IN (' + @location_list +')
				) t9
				;')
--exec(''+ @query+'')


