DECLARE @providerId int
DECLARE @programId int

IF NOT EXISTS(SELECT id FROM lodging.BedLog WHERE participantId = :participantId AND bedId = :bedId AND  eventStart = :eventStart)
BEGIN
	INSERT INTO lodging.BedLog (participantId, bedId, eventStart,reservationId)
	VALUES (:participantId, :bedId, :eventStart, :reservationId)
END
UPDATE lodging.Reservation SET timeRetired = GETDATE() , referralStatus = 'Checked-In' WHERE id = :reservationId

SELECT @providerId = providerId, @programId = programId
FROM lodging.Reservation
where id = :reservationId

UPDATE participant.referral
SET Status_Id = 13 
where participantId = :participantId and programId = @programId and providerId = @providerId