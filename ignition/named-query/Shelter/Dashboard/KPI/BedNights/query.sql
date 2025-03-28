DECLARE @startDate DATETIME ;
DECLARE @endDate DATETIME ;

SET @startDate = :startDate
SET @endDate = :endDate

;WITH frb As (
SELECT [Facility].[id] AS facilityId, [Room].[id] AS roomId, [Bed].[id] AS bedId
		, [Facility].[facilityName] AS [Shelter Name]
FROM [lodging].[Bed]
	INNER JOIN [lodging].[Room] ON [Bed].[roomId] = [Room].[id]
	INNER JOIN [lodging].[Facility] ON [Room].[facilityId] = [Facility].[id]
WHERE ([Facility].[timeRetired] is NULL 
	AND [Room].[timeRetired] is NULL
	AND [Bed].[timeRetired] is NULL) 
)

, bedlog As (
SELECT b.participantId, b.[bedId] , r.programId, frb.[Shelter Name], --eventStart, eventEnd
CASE WHEN eventStart < @startDate THEN @startDate else eventStart end as eventStart,
CASE WHEN eventEnd IS NULL then @endDate
WHEN eventEnd > @endDate then @endDate
ELSE eventEnd end as eventEnd
FROM [lodging].[BedLog] b
LEFT JOIN [lodging].[Reservation] r ON reservationId = r.id
LEFT JOIN frb ON frb.bedId = b.bedId
WHERE ([eventStart] IS NOT NULL  
	AND {selectedShelters}
	AND (ISNULL(r.programId,-1) in {selectedPrograms})
	AND (((eventStart >= @startDate and eventStart <= @endDate) or (eventEnd >= @startDate and eventEnd <= @endDate)) or ((eventEnd is null or eventEnd = '') and eventStart <= @endDate))
	)
)

SELECT 
	--bedlog.participantId, bedlog.[bedId] , bedlog.programId, bedlog.[Shelter Name], bedlog.eventStart, bedlog.eventEnd,
	--DATEDIFF(day, bedlog.eventStart, bedlog.eventEnd) as 'participantStay'
	SUM(DATEDIFF(day, bedlog.eventStart, bedlog.eventEnd)) as 'participantStayAvg'
FROM 
	bedlog