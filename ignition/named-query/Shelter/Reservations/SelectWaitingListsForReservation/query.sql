SELECT distinct r.programName as value, r.programName as label
FROM participant.ReferralDashboard  r
WHERE r.programName IS NOT NULL and r.referralStatus = 'Approved'
AND CONCAT(r.participantid,r.programName) not in (SELECT CONCAT(participantId,waitingListName) from lodging.Reservation res where timeRetired is NULL and reservationExpiration IS NULL )
