SELECT 
	 [id]
	,[facilityName]
FROM [lodging].[Facility]
WHERE [timeRetired] IS NULL
ORDER BY [facilityName]