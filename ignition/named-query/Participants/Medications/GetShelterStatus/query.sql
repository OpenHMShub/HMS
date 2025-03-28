
	SELECT
	
	 [lodging].[Room].facilityId  as 'shelterId'
	
FROM
	[lodging].[BedLog] 
	LEFT JOIN [lodging].[Bed] ON [lodging].[BedLog].bedId = [lodging].[Bed].id
	LEFT JOIN [lodging].[Room] ON [lodging].[Bed].roomId = [lodging].[Room].id
	LEFT JOIN [lodging].[Facility] ON [lodging].[Room].facilityId = [lodging].[Facility].id
WHERE
	[lodging].[BedLog].participantId = :Participant_Id and [lodging].[BedLog].EventEnd is null
	
		