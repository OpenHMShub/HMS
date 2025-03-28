DECLARE @today as datetime = GetDate();
SELECT
	 [participant].[Participant].id  as 'participant_id',
	 [lodging].[Facility].facilityName as 'facility_name',
	 [lodging].[Room].facilityId  as 'facilty_id',
	 [lodging].[Bed].roomId as 'room_id',
	 [lodging].[Room].roomName as 'room_name',
	 [lodging].[Reservation].bedId as 'bed_id',
	 [lodging].[Bed].bedName as 'bed_name', 
	 [lodging].[Reservation].timeCreated  as 'reservation_created',
	 [lodging].[Reservation].timeRetired  as 'reservation_completed',
	 [lodging].[Reservation].reservationStart  as 'start_date',
	 [lodging].[Reservation].reservationEnd  as 'end_date'
FROM
	[participant].[Participant]
	INNER JOIN [lodging].[Reservation] ON [lodging].[Reservation].participantId = [participant].[Participant].id
	LEFT JOIN [lodging].[Bed] ON [lodging].[Reservation].bedId = [lodging].[Bed].id
	LEFT JOIN [lodging].[Room] ON [lodging].[Bed].roomId = [lodging].[Room].id
	LEFT JOIN [lodging].[Facility] ON [lodging].[Room].facilityId = [lodging].[Facility].id
WHERE
	[lodging].[Reservation].timeRetired IS NULL
ORDER By participant_id