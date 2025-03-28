Update lodging.Reservation 
Set bedId = :bedId , participantId = :participantId, reservationStart = :reservationStart, reservationEnd = :reservationEnd, timeCreated = current_timestamp, notes = :notes, providerTypeId = :providerTypeId, providerId = :providerId, programId = :programId, waitingListName = :waitingListName, reservationType = :reservationType, prescribedControlledSubstance = :prescribedControlledSubstance
Where id = :reservationID;

Update participant.Referral
Set ReasonForEntry_Id = :reasonForEntryId
Where id = :referralId;
