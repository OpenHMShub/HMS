DECLARE @startDate DATETIME ;
DECLARE @endDate DATETIME ;

SET @startDate = :startDate
SET @endDate = :endDate

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

, r AS (
SELECT DISTINCT [bedId]
FROM [lodging].[Reservation]  
WHERE ([Reservation].[timeRetired] IS NULL
	AND [Reservation].[reservationStart] IS NOT NULL    
	AND (((reservationStart >= @startDate and reservationStart <= @endDate) or (reservationEnd >= @startDate and reservationEnd <= @endDate)) or ((@startDate >= reservationStart and @startDate <= reservationEnd) or (@endDate >= reservationStart and @endDate <= reservationEnd)))
	)
)

,  o AS (
SELECT b.participantId, b.[bedId] , r.programId,
CASE WHEN eventStart < @startDate THEN @startDate else eventStart end as eventStart,
CASE WHEN eventEnd IS NULL then @endDate
WHEN eventEnd > @endDate then @endDate
ELSE eventEnd end as eventEnd
FROM [lodging].[BedLog]  b
LEFT JOIN [lodging].[Reservation] r ON b.reservationId = r.id
WHERE ([eventStart] IS NOT NULL  
	AND [eventEnd] IS NULL
	AND (ISNULL(r.programId,-1) in {selectedPrograms})
	AND (((eventStart >= @startDate and eventStart <= @endDate) or (eventEnd >= @startDate and eventEnd <= @endDate)) or ((eventEnd is null or eventEnd = '') and eventStart <= @endDate))
)
)

,facGroup AS (
SELECT 
	frb.facilityId
,COUNT(frb.bedId) bedQty
,COUNT(r.bedId) cntRes
,COUNT(o.bedId) cntOcc
FROM frb 
LEFT JOIN r ON r.bedId = frb.bedId
LEFT JOIN o ON o.bedId = frb.bedId
Where {selectedShelters}
GROUP BY frb.facilityId
)

SELECT SUM(facGroup.[bedQty]) AS [Total Beds]
	,SUM((facGroup.bedQty - facGroup.cntRes - facGroup.cntOcc)) AS [Available Beds]
FROM facGroup
INNER JOIN [lodging].[Facility] ON facGroup.[facilityId] = [Facility].[id]
LEFT JOIN [lodging].[FacilityType] ON [FacilityType].[id] = [Facility].[facilityTypeId]
WHERE [FacilityType].[timeRetired]  IS NULL 
--ORDER BY [Facility].[facilityName]	