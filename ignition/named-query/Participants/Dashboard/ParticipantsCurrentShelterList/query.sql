DECLARE @today as datetime = GetDate();
SELECT
	 [participant].[Participant].id  as 'participant_id',
	 [lodging].[Facility].facilityName as 'facility_name',
	 [lodging].[Room].facilityId  as 'facilty_id',
	 [lodging].[Bed].roomId as 'room_id',
	 [lodging].[Room].roomName as 'room_name',
	 [lodging].[BedLog].bedId as 'bed_id',
	 [lodging].[Bed].bedName as 'bed_name', 
	 max([lodging].[BedLog].eventStart)  as 'last_check_in',
	 max([lodging].[BedLog].eventEnd)  as 'last_check_out'
FROM
	[participant].[Participant]
	INNER JOIN [lodging].[BedLog] ON [lodging].[BedLog].participantId = [participant].[Participant].id
	LEFT JOIN [lodging].[Bed] ON [lodging].[BedLog].bedId = [lodging].[Bed].id
	LEFT JOIN [lodging].[Room] ON [lodging].[Bed].roomId = [lodging].[Room].id
	LEFT JOIN [lodging].[Facility] ON [lodging].[Room].facilityId = [lodging].[Facility].id
GROUP By 
	[participant].[Participant].id,
	[lodging].[Facility].facilityName,
	[lodging].[Room].facilityId,
	[lodging].[Bed].roomId,
	[lodging].[Room].roomName,
	[lodging].[BedLog].bedId,
	[lodging].[Bed].bedName
HAVING
	max([lodging].[BedLog].eventStart) >= @today
	AND IsNull(max([lodging].[BedLog].eventEnd),@today) <= @today
ORDER By participant_id