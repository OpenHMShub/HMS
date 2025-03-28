DECLARE @fromDate datetime
		,@toDate datetime;
		
SET @fromDate = :startDate
SET @toDate = :endDate

;WITH frb As (
SELECT [Facility].[id] AS facilityId, [Room].[id] AS roomId, [Bed].[id] AS bedId
		,[Facility].[facilityName] AS [Shelter Name]
FROM [lodging].[Bed]
	INNER JOIN [lodging].[Room] ON [Bed].[roomId] = [Room].[id]
	INNER JOIN [lodging].[Facility] ON [Room].[facilityId] = [Facility].[id]
WHERE ([Facility].[timeRetired] is NULL 
	AND [Room].[timeRetired] is NULL
	AND [Bed].[timeRetired] is NULL) 
)

, cte AS (
SELECT b.[id]
	,b.[bedId]
	,b.[participantId]
	,b.[eventStart]
	,b.[eventEnd]
	,CASE WHEN b.[eventStart] < @fromDate THEN @fromDate ELSE eventStart END [correctedStart]
	, ISNULL(b.[eventEnd], @toDate) [correctedEnd]
FROM [lodging].[BedLog] b
LEFT JOIN [lodging].[Reservation] r ON b.reservationId = r.id
LEFT JOIN frb ON frb.bedId = b.bedId
WHERE 
	ISNULL([eventEnd], @fromDate) >= @fromDate AND [eventStart] <= @toDate
	AND (ISNULL(r.programId,-1) in {selectedPrograms})
	AND {selectedShelters}
)

SELECT [id]
	,[bedId]
	,[participantId]
	,[eventStart]
	,[eventEnd]
	,[correctedStart]
	,[correctedEnd]
, DATEDIFF(hour,[correctedStart],[correctedEnd]) deltaHours
FROM cte	