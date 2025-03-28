DECLARE @date VARCHAR(200) = :date --'2023-06-02'
DECLARE @locationId int = :locationId
DECLARE @facilitatorId int = :facilitatorId
DECLARE @categoryId int = :categoryId
DECLARE @eventName VARCHAR(200) = :eventName
DECLARE @location_list varchar(max),@location_list1 varchar(max), @query varchar(max) 

SELECT TIME, location, STRING_AGG(concat('(',facilitatorName,')', EventName), ',') as 'EventName'
FROM
(

SELECT '7:00A' AS 'TIME', la.locationAlias as location, l.name AS 'actuallocation', concat(e.name,'-color-',ISNULL(c.color, 'None'), '-desc-', ISNULL(s.description,'')) AS 'EventName',
(SELECT TOP 1 h.firstName 
	FROM participant.EventSelectedFacilitators esf, humans.human h
	where esf.facilitatorHumanId = h.id and esf.eventId = e.id and esf.timeRetired IS NULL ORDER BY esf.timeCreated) as facilitatorName
FROM participant.EventLocations l
LEFT JOIN [participant].[EventLocationsAliases] la on l.name = la.locationName
LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
LEFT JOIN participant.Events e on s.[eventId] = e.id 
LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]

WHERE
s.timeRetired IS NULL AND e.timeRetired IS NULL AND
(s.[locationId] = @locationId OR @locationId = NULL OR @locationId = '' OR @locationId = -1 )
--AND (e.[facilitatorEmployeeId] = @facilitatorId OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (@facilitatorId in (SELECT facilitatorHumanId FROM participant.EventSelectedFacilitators where eventId = e.id) OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (e.[categoryId] = @categoryId OR @categoryId = NULL OR @categoryId = '' OR @categoryId = -1)
AND ( e.[name] = @eventName OR @eventName = NULL OR @eventName = '')					
AND (s.[startsOn] between concat(@date ,' 07:00:00') and concat(@date ,' 07:29:59')) 
AND
(
(
(e.id in (
SELECT distinct eventId from participant.EventSelectedAttendeeCategories
where  {selectedAttendeeCategories} 
))
OR
 :filterByAttendeeCategories = 0 )

)
UNION
SELECT '7:30A' AS 'TIME',la.locationAlias as location, l.name AS 'actuallocation', concat(e.name,'-color-',ISNULL(c.color, 'None'), '-desc-', ISNULL(s.description,'')) AS 'EventName',
(SELECT TOP 1 h.firstName 
	FROM participant.EventSelectedFacilitators esf, humans.human h
	where esf.facilitatorHumanId = h.id and esf.eventId = e.id and esf.timeRetired IS NULL ORDER BY esf.timeCreated) as facilitatorName
FROM participant.EventLocations l
LEFT JOIN [participant].[EventLocationsAliases] la on l.name = la.locationName
LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
LEFT JOIN participant.Events e on s.[eventId] = e.id 
LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
WHERE 
s.timeRetired IS NULL AND e.timeRetired IS NULL AND
(s.[locationId] = @locationId OR @locationId = NULL OR @locationId = '' OR @locationId = -1 )
--AND (e.[facilitatorEmployeeId] = @facilitatorId OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (@facilitatorId in (SELECT facilitatorHumanId FROM participant.EventSelectedFacilitators where eventId = e.id) OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (e.[categoryId] = @categoryId OR @categoryId = NULL OR @categoryId = '' OR @categoryId = -1)
AND ( e.[name] = @eventName OR @eventName = NULL OR @eventName = '' OR @eventName = 'null')					
AND (s.[startsOn] between concat(@date ,' 07:30:00') and concat(@date ,' 07:59:59')) 
AND
(
(
(e.id in (
SELECT distinct eventId from participant.EventSelectedAttendeeCategories
where  {selectedAttendeeCategories} 
))
OR
 :filterByAttendeeCategories = 0 )

)
UNION

SELECT '8:00A' AS 'TIME', la.locationAlias as location, l.name AS 'actuallocation', concat(e.name,'-color-',ISNULL(c.color, 'None'), '-desc-', ISNULL(s.description,'')) AS 'EventName',
(SELECT TOP 1 h.firstName 
	FROM participant.EventSelectedFacilitators esf, humans.human h
	where esf.facilitatorHumanId = h.id and esf.eventId = e.id and esf.timeRetired IS NULL ORDER BY esf.timeCreated) as facilitatorName
FROM participant.EventLocations l
LEFT JOIN [participant].[EventLocationsAliases] la on l.name = la.locationName
LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
LEFT JOIN participant.Events e on s.[eventId] = e.id 
LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
WHERE 
s.timeRetired IS NULL AND e.timeRetired IS NULL AND
(s.[locationId] = @locationId OR @locationId = NULL OR @locationId = '' OR @locationId = -1 )
--AND (e.[facilitatorEmployeeId] = @facilitatorId OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (@facilitatorId in (SELECT facilitatorHumanId FROM participant.EventSelectedFacilitators where eventId = e.id) OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (e.[categoryId] = @categoryId OR @categoryId = NULL OR @categoryId = '' OR @categoryId = -1)
AND ( e.[name] = @eventName OR @eventName = NULL OR @eventName = '')					
AND (s.[startsOn] between concat(@date ,' 08:00:00') and concat(@date ,' 08:59:59')) 
AND
(
(
(e.id in (
SELECT distinct eventId from participant.EventSelectedAttendeeCategories
where  {selectedAttendeeCategories} 
))
OR
 :filterByAttendeeCategories = 0 )

)	
UNION

SELECT '9:00A' AS 'TIME', la.locationAlias as location, l.name AS 'actuallocation', concat(e.name,'-color-',ISNULL(c.color, 'None'), '-desc-', ISNULL(s.description,'')) AS 'EventName',
(SELECT TOP 1 h.firstName 
	FROM participant.EventSelectedFacilitators esf, humans.human h
	where esf.facilitatorHumanId = h.id and esf.eventId = e.id and esf.timeRetired IS NULL ORDER BY esf.timeCreated) as facilitatorName
FROM participant.EventLocations l
LEFT JOIN [participant].[EventLocationsAliases] la on l.name = la.locationName
LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
LEFT JOIN participant.Events e on s.[eventId] = e.id 
LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
WHERE 
s.timeRetired IS NULL AND e.timeRetired IS NULL AND
(s.[locationId] = @locationId OR @locationId = NULL OR @locationId = '' OR @locationId = -1 )
--AND (e.[facilitatorEmployeeId] = @facilitatorId OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (@facilitatorId in (SELECT facilitatorHumanId FROM participant.EventSelectedFacilitators where eventId = e.id) OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (e.[categoryId] = @categoryId OR @categoryId = NULL OR @categoryId = '' OR @categoryId = -1)
AND ( e.[name] = @eventName OR @eventName = NULL OR @eventName = '')					
AND (s.[startsOn] between concat(@date ,' 09:00:00') and concat(@date ,' 10:29:59')) 
AND
(
(
(e.id in (
SELECT distinct eventId from participant.EventSelectedAttendeeCategories
where  {selectedAttendeeCategories} 
))
OR
 :filterByAttendeeCategories = 0 )

)
UNION

SELECT '10:30A' AS 'TIME', la.locationAlias as location, l.name AS 'actuallocation', concat(e.name,'-color-',ISNULL(c.color, 'None'), '-desc-', ISNULL(s.description,'')) AS 'EventName',
(SELECT TOP 1 h.firstName 
	FROM participant.EventSelectedFacilitators esf, humans.human h
	where esf.facilitatorHumanId = h.id and esf.eventId = e.id and esf.timeRetired IS NULL ORDER BY esf.timeCreated) as facilitatorName
FROM participant.EventLocations l
LEFT JOIN [participant].[EventLocationsAliases] la on l.name = la.locationName
LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
LEFT JOIN participant.Events e on s.[eventId] = e.id 
LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
WHERE 
s.timeRetired IS NULL AND e.timeRetired IS NULL AND
(s.[locationId] = @locationId OR @locationId = NULL OR @locationId = '' OR @locationId = -1 )
--AND (e.[facilitatorEmployeeId] = @facilitatorId OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (@facilitatorId in (SELECT facilitatorHumanId FROM participant.EventSelectedFacilitators where eventId = e.id) OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (e.[categoryId] = @categoryId OR @categoryId = NULL OR @categoryId = '' OR @categoryId = -1)
AND ( e.[name] = @eventName OR @eventName = NULL OR @eventName = '')					
AND (s.[startsOn] between concat(@date ,' 10:30:00') and concat(@date ,' 13:14:59')) 
AND
(
(
(e.id in (
SELECT distinct eventId from participant.EventSelectedAttendeeCategories
where  {selectedAttendeeCategories} 
))
OR
 :filterByAttendeeCategories = 0 )

)
UNION

SELECT '1:15P' AS 'TIME', la.locationAlias as location, l.name AS 'actuallocation', concat(e.name,'-color-',ISNULL(c.color, 'None'), '-desc-', ISNULL(s.description,'')) AS 'EventName',
(SELECT TOP 1 h.firstName 
	FROM participant.EventSelectedFacilitators esf, humans.human h
	where esf.facilitatorHumanId = h.id and esf.eventId = e.id and esf.timeRetired IS NULL ORDER BY esf.timeCreated) as facilitatorName
FROM participant.EventLocations l
LEFT JOIN [participant].[EventLocationsAliases] la on l.name = la.locationName
LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
LEFT JOIN participant.Events e on s.[eventId] = e.id 
LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
WHERE 
s.timeRetired IS NULL AND e.timeRetired IS NULL AND
(s.[locationId] = @locationId OR @locationId = NULL OR @locationId = '' OR @locationId = -1 )
--AND (e.[facilitatorEmployeeId] = @facilitatorId OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (@facilitatorId in (SELECT facilitatorHumanId FROM participant.EventSelectedFacilitators where eventId = e.id) OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (e.[categoryId] = @categoryId OR @categoryId = NULL OR @categoryId = '' OR @categoryId = -1)
AND ( e.[name] = @eventName OR @eventName = NULL OR @eventName = '')					
AND (s.[startsOn] between concat(@date ,' 13:15:00') and concat(@date ,' 14:29:59')) 
AND
(
(
(e.id in (
SELECT distinct eventId from participant.EventSelectedAttendeeCategories
where  {selectedAttendeeCategories} 
))
OR
 :filterByAttendeeCategories = 0 )

)
UNION

SELECT '2:30P(GH)' AS 'TIME', la.locationAlias as location, l.name AS 'actuallocation', concat(e.name,'-color-',ISNULL(c.color, 'None'), '-desc-', ISNULL(s.description,'')) AS 'EventName',
(SELECT TOP 1 h.firstName 
	FROM participant.EventSelectedFacilitators esf, humans.human h
	where esf.facilitatorHumanId = h.id and esf.eventId = e.id and esf.timeRetired IS NULL ORDER BY esf.timeCreated) as facilitatorName
FROM participant.EventLocations l
LEFT JOIN [participant].[EventLocationsAliases] la on l.name = la.locationName
LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
LEFT JOIN participant.Events e on s.[eventId] = e.id 
LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
WHERE
s.timeRetired IS NULL AND  e.timeRetired IS NULL AND
(s.[locationId] = @locationId OR @locationId = NULL OR @locationId = '' OR @locationId = -1 )
--AND (e.[facilitatorEmployeeId] = @facilitatorId OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (@facilitatorId in (SELECT facilitatorHumanId FROM participant.EventSelectedFacilitators where eventId = e.id) OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (e.[categoryId] = @categoryId OR @categoryId = NULL OR @categoryId = '' OR @categoryId = -1)
AND ( e.[name] = @eventName OR @eventName = NULL OR @eventName = '')					
AND (s.[startsOn] between concat(@date ,' 14:30:00') and concat(@date ,' 15:29:59')) 
AND
(
(
(e.id in (
SELECT distinct eventId from participant.EventSelectedAttendeeCategories
where  {selectedAttendeeCategories} 
))
OR
 :filterByAttendeeCategories = 0 )

)
UNION

SELECT '3:30P(GH)' AS 'TIME', la.locationAlias as location, l.name AS 'actuallocation', concat(e.name,'-color-',ISNULL(c.color, 'None'), '-desc-', ISNULL(s.description,'')) AS 'EventName',
(SELECT TOP 1 h.firstName 
	FROM participant.EventSelectedFacilitators esf, humans.human h
	where esf.facilitatorHumanId = h.id and esf.eventId = e.id and esf.timeRetired IS NULL ORDER BY esf.timeCreated) as facilitatorName
FROM participant.EventLocations l
LEFT JOIN [participant].[EventLocationsAliases] la on l.name = la.locationName
LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
LEFT JOIN participant.Events e on s.[eventId] = e.id 
LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
WHERE 
s.timeRetired IS NULL AND e.timeRetired IS NULL AND
(s.[locationId] = @locationId OR @locationId = NULL OR @locationId = '' OR @locationId = -1 )
--AND (e.[facilitatorEmployeeId] = @facilitatorId OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (@facilitatorId in (SELECT facilitatorHumanId FROM participant.EventSelectedFacilitators where eventId = e.id) OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (e.[categoryId] = @categoryId OR @categoryId = NULL OR @categoryId = '' OR @categoryId = -1)
AND ( e.[name] = @eventName OR @eventName = NULL OR @eventName = '')					
AND (s.[startsOn] between concat(@date ,' 15:30:00') and concat(@date ,' 15:59:59')) 
AND
(
(
(e.id in (
SELECT distinct eventId from participant.EventSelectedAttendeeCategories
where  {selectedAttendeeCategories} 
))
OR
 :filterByAttendeeCategories = 0 )

)
UNION

SELECT 'GH Evening' AS 'TIME', la.locationAlias as location, l.name AS 'actuallocation', concat(e.name,'-color-',ISNULL(c.color, 'None'), '-desc-', ISNULL(s.description,'')) AS 'EventName',
(SELECT TOP 1 h.firstName 
	FROM participant.EventSelectedFacilitators esf, humans.human h
	where esf.facilitatorHumanId = h.id and esf.eventId = e.id and esf.timeRetired IS NULL ORDER BY esf.timeCreated) as facilitatorName
FROM participant.EventLocations l
LEFT JOIN [participant].[EventLocationsAliases] la on l.name = la.locationName
LEFT JOIN [participant].[EventSchedule] s on l.id = s.[locationId]
LEFT JOIN participant.Events e on s.[eventId] = e.id 
LEFT JOIN [participant].[EventCategories] c on e.[categoryId] = c.[id]
WHERE 
s.timeRetired IS NULL AND e.timeRetired IS NULL AND
(s.[locationId] = @locationId OR @locationId = NULL OR @locationId = '' OR @locationId = -1 )
--AND (e.[facilitatorEmployeeId] = @facilitatorId OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (@facilitatorId in (SELECT facilitatorHumanId FROM participant.EventSelectedFacilitators where eventId = e.id) OR @facilitatorId = NULL OR @facilitatorId = '' OR @facilitatorId = -1)
AND (e.[categoryId] = @categoryId OR @categoryId = NULL OR @categoryId = '' OR @categoryId = -1)
AND ( e.[name] = @eventName OR @eventName = NULL OR @eventName = '')					
AND (s.[startsOn] between concat(@date ,' 16:00:00') and concat(@date ,' 23:59:59')) 
AND
(
(
(e.id in (
SELECT distinct eventId from participant.EventSelectedAttendeeCategories
where  {selectedAttendeeCategories} 
))
OR
 :filterByAttendeeCategories = 0 )

)
) x
GROUP BY x.TIME, x.location

