;WITH cteEvent AS (
SELECT 
	 [EventAttendance].[id]
	,[EventAttendance].[eventId]
	,[EventAttendance].[humanId]
	,[EventAttendance].[checkin]
	,[EventAttendance].[checkout]
	,[EventAttendance].[autonote]
	,[Gender].[genderName]
	,[Employee].[id] AS [Employee_id]
	,CONCAT_WS(' ', [Human].[firstName],[Human].[middleName],[Human].[lastName]) AS [StaffName]
	,[Human].[genderId]
	,[Human].[dob]
	,DATEDIFF(year,[Human].[dob],GETDATE()) AS [Age]
	,[CalendarEvents].[calendarId]
	,[CalendarEvents].[name] AS [CalendarEvents_name]
FROM [calendar].[EventAttendance]
	INNER JOIN [humans].[Human] ON [Human].[id] = [EventAttendance].[humanId]
	-- INNER JOIN [participant].[Participant] ON [Participant].[humanId] = [Human].[id]
	INNER JOIN [staff].[Employee] ON [Human].[id] = [Employee].[humanId]
	INNER JOIN [humans].[Gender] ON [Gender].[id] = [Human].[genderId]

	LEFT JOIN [calendar].[CalendarEvents] ON [CalendarEvents].[id] = [EventAttendance].[eventId]
)

,cteInOut AS (
SELECT 
	 [id] AS [EventAttendanceId]
	,[eventId]
	,[humanId]
	,[genderId]
	,[dob]
	,[Age]
	,[Employee_id]
	,[checkin] AS [TimeStamp]
	,[StaffName]
	,[calendarId]
	,[CalendarEvents_name]
	,1 AS [checkIO]
	,'checkin' AS [CheckInOut]
	,[genderName]
FROM cteEvent
WHERE checkin IS NOT NULL
UNION ALL
SELECT 
	 [id] AS [EventAttendanceId]
	,[eventId]
	,[humanId]
	,[genderId]
	,[dob]
	,[Age]
	,[Employee_id]
	,[checkout] AS [TimeStamp]
	,[StaffName]
	,[calendarId]
	,[CalendarEvents_name]
	,0 AS [checkIO]
	,'checkout' AS [CheckInOut]
	,[genderName]
FROM cteEvent
WHERE checkout IS NOT NULL
)


SELECT 
	COUNT( DISTINCT [CalendarEvents_name]  ) AS TotalEvents
	
FROM cteInOut
WHERE 1=1
	AND ([calendarId] = :calendarId OR :calendarId IS NULL)
	AND ([CalendarEvents_name] = :calEventName OR :calEventName IS NULL)
	AND ([checkIO] = :checkIO OR :checkIO IS NULL)
	AND ([TimeStamp] >= :dateFrom OR :dateFrom IS NULL)
	AND ([TimeStamp] <= :dateTo OR :dateTo IS NULL)
	
	AND (
		:searchText = '' 
		OR :searchText IS NULL 
		OR [StaffName] LIKE CONCAT('%',:searchText,'%') 
		OR [CalendarEvents_name] LIKE CONCAT('%',:searchText,'%') 
		OR [genderName] LIKE CONCAT('%',:searchText,'%') 
		OR [checkInOut] LIKE CONCAT('%',:searchText,'%')
)