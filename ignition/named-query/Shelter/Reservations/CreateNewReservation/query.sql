DECLARE @newReferralID AS INT

IF :referralId IS NULL
BEGIN
INSERT INTO participant.referral (participantId, programId, ProviderId, Status_Id, Type_Id, timeCreated, ReasonForEntry_Id)
VALUES (:participantId, :programId, :providerId, 5, 2, current_timestamp, :reasonForEntryId)
SELECT @newReferralID = SCOPE_IDENTITY()

END
ELSE
BEGIN
	SET @newReferralID = :referralId
	-- also update the referral status
	UPDATE participant.referral
	SET Status_Id = 5 
	where id = @newReferralID
END

INSERT INTO lodging.Reservation (bedId, participantId, reservationStart, reservationEnd, timeCreated, notes, providerTypeId, providerId, programId, waitingListName, reservationType, referralStatus, referralId, prescribedControlledSubstance)
VALUES ( :bedId, :participantId, :reservationStart, :reservationEnd, current_timestamp, :notes, :providerTypeId, :providerId, :programId, :waitingListName, :reservationType, :referralStatus, @newReferralID, :prescribedControlledSubstance)

-- Delete from waiting List if Participant exists in any of the waiting lists
UPDATE shelter.WaitList 
SET dateremoved = current_timestamp
WHERE participantid = :participantId

-- Get the new reservation Id
SELECT id 
from lodging.Reservation
where bedId = :bedId and participantId = :participantId and reservationStart = :reservationStart and reservationEnd=  :reservationEnd
and notes = :notes