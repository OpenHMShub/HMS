DECLARE @startDate DATETIME ;
DECLARE @endDate DATETIME ;

SET @startDate = :startDate
SET @endDate = :endDate

;WITH frb As (
SELECT [Facility].[id] AS facilityId, [Room].[id] AS roomId, [Bed].[id] AS bedId
FROM [lodging].[Bed]
	INNER JOIN [lodging].[Room] ON [Bed].[roomId] = [Room].[id]
	INNER JOIN [lodging].[Facility] ON [Room].[facilityId] = [Facility].[id]
WHERE ([Facility].[timeRetired] is NULL 
	AND [Room].[timeRetired] is NULL
	AND [Bed].[timeRetired] is NULL) 
)

,  o AS (
SELECT b.participantId, b.[bedId] , 
CASE WHEN b.eventStart < @startDate THEN @startDate else b.eventStart end as eventStart,
CASE WHEN b.eventEnd IS NULL then @endDate
WHEN b.eventEnd > @endDate then @endDate
ELSE b.eventEnd end as eventEnd
FROM [lodging].[BedLog] b
LEFT JOIN [lodging].[Reservation] r ON b.reservationId = r.id
WHERE ([eventStart] IS NOT NULL    
	AND (ISNULL(r.programId,-1) in {selectedPrograms})
	AND (((eventStart >= @startDate and eventStart <= @endDate) or (eventEnd >= @startDate and eventEnd <= @endDate)) or ((eventEnd is null or eventEnd = '') and eventStart <= @endDate))
)
)

,facGroup AS (
SELECT 
	frb.facilityId

, COUNT(distinct o.participantId) uniqueParticipants

, SUM(DATEDIFF(day, o.eventStart, o.eventEnd)) as totalBedNights
FROM frb 
LEFT JOIN o ON o.bedId = frb.bedId
GROUP BY frb.facilityId
)

SELECT [Facility].[id]
	,case when [Facility].[facilityName] in {selectedShelters} then 'true' else 'false' end as 'isShelterSelected'
	,[Facility].[facilityName] AS [Shelter Name]
	,[FacilityType].[facilityTypeName] AS [Shelter Type]

	, facGroup.uniqueParticipants
	, ISNULL(facGroup.totalBedNights,0) as 'totalBedNights'
	, ISNULL(facGroup.totalBedNights / facGroup.uniqueParticipants, 0) as avgDaysPerOccupant
FROM facGroup
INNER JOIN [lodging].[Facility] ON facGroup.[facilityId] = [Facility].[id]
LEFT JOIN [lodging].[FacilityType] ON [FacilityType].[id] = [Facility].[facilityTypeId]
WHERE [FacilityType].[timeRetired]  IS NULL
ORDER BY [Facility].[facilityName]