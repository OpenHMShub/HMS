DECLARE @date VARCHAR(200) = :date --'2023-06-02'

SELECT TIME, location, STRING_AGG(note, ',') as 'note'
FROM
(

SELECT '7:00A' AS 'TIME', n.[note]
      ,a.locationAlias as 'location'
  FROM [participant].[EventWeeklyScheduleNote] n
  LEFT JOIN participant.EventLocations e on n.locationId = e.id
  LEFT JOIN participant.EventLocationsAliases a on a.locationName = e.name
  WHERE (n.date between concat(@date ,' 07:00:00') and concat(@date ,' 07:29:59')) 
  
UNION

SELECT '7:30A' AS 'TIME',n.[note]
      ,a.locationAlias as 'location'
  FROM [participant].[EventWeeklyScheduleNote] n
  LEFT JOIN participant.EventLocations e on n.locationId = e.id
  LEFT JOIN participant.EventLocationsAliases a on a.locationName = e.name
  WHERE (n.date between concat(@date ,' 07:30:00') and concat(@date ,' 07:59:59')) 

UNION

SELECT '8:00A' AS 'TIME', n.[note]
      ,a.locationAlias as 'location'
  FROM [participant].[EventWeeklyScheduleNote] n
  LEFT JOIN participant.EventLocations e on n.locationId = e.id
  LEFT JOIN participant.EventLocationsAliases a on a.locationName = e.name
  WHERE (n.date between concat(@date ,' 08:00:00') and concat(@date ,' 08:59:59')) 
	
UNION

SELECT '9:00A' AS 'TIME', n.[note]
      ,a.locationAlias as 'location'
  FROM [participant].[EventWeeklyScheduleNote] n
  LEFT JOIN participant.EventLocations e on n.locationId = e.id
  LEFT JOIN participant.EventLocationsAliases a on a.locationName = e.name
  WHERE (n.date between concat(@date ,' 09:00:00') and concat(@date ,' 10:29:59')) 

UNION

SELECT '10:30A' AS 'TIME', n.[note]
      ,a.locationAlias as 'location'
  FROM [participant].[EventWeeklyScheduleNote] n
  LEFT JOIN participant.EventLocations e on n.locationId = e.id
  LEFT JOIN participant.EventLocationsAliases a on a.locationName = e.name
  WHERE (n.date between concat(@date ,' 10:30:00') and concat(@date ,' 13:14:59')) 

UNION

SELECT '1:15P' AS 'TIME', n.[note]
      ,a.locationAlias as 'location'
  FROM [participant].[EventWeeklyScheduleNote] n
  LEFT JOIN participant.EventLocations e on n.locationId = e.id
  LEFT JOIN participant.EventLocationsAliases a on a.locationName = e.name
  WHERE (n.date between concat(@date ,' 13:15:00') and concat(@date ,' 14:29:59')) 

UNION

SELECT '2:30P(GH)' AS 'TIME', n.[note]
      ,a.locationAlias as 'location'
  FROM [participant].[EventWeeklyScheduleNote] n
  LEFT JOIN participant.EventLocations e on n.locationId = e.id
  LEFT JOIN participant.EventLocationsAliases a on a.locationName = e.name
  WHERE (n.date between concat(@date ,' 14:30:00') and concat(@date ,' 15:29:59')) 

UNION

SELECT '3:30P(GH)' AS 'TIME', n.[note]
      ,a.locationAlias as 'location'
  FROM [participant].[EventWeeklyScheduleNote] n
  LEFT JOIN participant.EventLocations e on n.locationId = e.id
  LEFT JOIN participant.EventLocationsAliases a on a.locationName = e.name
  WHERE (n.date between concat(@date ,' 15:30:00') and concat(@date ,' 15:59:59')) 

UNION

SELECT 'GH Evening' AS 'TIME', n.[note]
      ,a.locationAlias as 'location'
  FROM [participant].[EventWeeklyScheduleNote] n
  LEFT JOIN participant.EventLocations e on n.locationId = e.id
  LEFT JOIN participant.EventLocationsAliases a on a.locationName = e.name
  WHERE (n.date between concat(@date ,' 16:00:00') and concat(@date ,' 23:59:59')) 

) x
GROUP BY x.TIME, x.location
