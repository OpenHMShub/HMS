
IF :waitListName = 'All' 
BEGIN
SELECT distinct r.participantid as value, r.name as label
FROM participant.ReferralDashboard  r
WHERE r.referralStatus = 'Approved' AND r.isActive = 1
order by r.name
-- and CONCAT(r.participantid,r.programName) not in (SELECT CONCAT(participantId,waitingListName) from lodging.Reservation res )

END
ELSE
BEGIN
SELECT distinct r.participantid as value, r.name as label
FROM participant.ReferralDashboard  r
WHERE r.referralStatus = 'Approved' 
and r.programName = :waitListName AND r.isActive = 1
order by r.name
-- and CONCAT(r.participantid,r.programName) not in (SELECT CONCAT(participantId,waitingListName) from lodging.Reservation res )

END