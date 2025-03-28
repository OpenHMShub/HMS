INSERT INTO [shelter].[WaitListSnapshot] ([totalPeopleOnWaitlist],[snapshotDate])
SELECT COUNT(participantId),CAST(GETDATE() as DATE )
FROM participant.ReferralDashboard  
WHERE referralStatus = 'Approved' and programName is not NULL
AND CONCAT(participantid,programName) not in (SELECT CONCAT(participantId,waitingListName) from lodging.Reservation res )
