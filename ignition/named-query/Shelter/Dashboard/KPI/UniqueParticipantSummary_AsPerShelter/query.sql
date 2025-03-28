DECLARE @startDate DATETIME ;
DECLARE @endDate DATETIME ;

SET @startDate = :startDate
SET @endDate = :endDate

;WITH frb As (
SELECT [Facility].[id] AS facilityId, [Room].[id] AS roomId, [Bed].[id] AS bedId
		, [Facility].FacilityName as [shelter name]
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
	COUNT(distinct o.participantId) uniqueParticipants
	, SUM(DATEDIFF(day, o.eventStart, o.eventEnd)) as totalBedNights
FROM frb 
LEFT JOIN o ON o.bedId = frb.bedId
Where {selectedShelters}
--GROUP BY frb.facilityId
)

SELECT facGroup.uniqueParticipants
FROM facGroup