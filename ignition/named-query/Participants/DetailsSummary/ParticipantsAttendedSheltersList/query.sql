DECLARE @today as datetime = GetDate();
SELECT
	 [participant].[Participant].id  as 'participant_id',
	 [lodging].[Facility].facilityName as 'facility_name',
	 [lodging].[Room].facilityId  as 'facilty_id',
	 [lodging].[Bed].roomId as 'room_id',
	 [lodging].[Room].roomName as 'room_name',
	 [lodging].[BedLog].bedId as 'bed_id',
	 [lodging].[Bed].bedName as 'bed_name', 
	 [lodging].[BedLog].eventStart as 'check_in',
	 [lodging].[BedLog].eventEnd as 'check_out'
FROM
	[participant].[Participant]
	INNER JOIN [lodging].[BedLog] ON [lodging].[BedLog].participantId = [participant].[Participant].id
	LEFT JOIN [lodging].[Bed] ON [lodging].[BedLog].bedId = [lodging].[Bed].id
	LEFT JOIN [lodging].[Room] ON [lodging].[Bed].roomId = [lodging].[Room].id
	LEFT JOIN [lodging].[Facility] ON [lodging].[Room].facilityId = [lodging].[Facility].id
WHERE [participant].[Participant].id =  :participantId 
AND ( :shelterName IS NULL or [lodging].[Facility].facilityName LIKE  :shelterName )
ORDER BY  [lodging].[BedLog].eventStart