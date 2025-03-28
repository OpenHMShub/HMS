
IF :waitListName = 'All' 
BEGIN
SELECT id, firstName,middleName,lastName,FullName,SSN
FROM
(
SELECT distinct r.participantid as id ,
ISNULL(h.firstName,'') as firstName,
ISNULL(h.middleName,'') as middleName,
ISNULL(h.lastName,'') as lastName,
RIGHT(h.SSN, 4) as SSN,
r.name as FullName
FROM participant.ReferralDashboard  r, humans.Human h, participant.Participant p
WHERE r.referralStatus = 'Approved' AND r.isActive = 1 and h.timeRetired is null and p.humanId = h.id and p.timeRetired is null and p.id = r.participantid
) x
WHERE 
{firstName} 
AND {middleName}
AND {lastName} 
AND {SSN}
--x.FullName like {searchText} OR x.SSN like {searchText}
order by FullName
-- and CONCAT(r.participantid,r.programName) not in (SELECT CONCAT(participantId,waitingListName) from lodging.Reservation res )

END
ELSE
BEGIN
SELECT id, firstName,middleName,lastName,FullName,SSN
FROM
(
SELECT distinct r.participantid as id,
ISNULL(h.firstName,'') as firstName,
ISNULL(h.middleName,'') as middleName,
ISNULL(h.lastName,'') as lastName,
RIGHT(h.SSN, 4) as SSN,
r.name as FullName
FROM participant.ReferralDashboard  r, humans.Human h, participant.Participant p
WHERE r.referralStatus = 'Approved' 
and r.programName = :waitListName AND r.isActive = 1 and h.timeRetired is null and p.humanId = h.id and p.timeRetired is null and p.id = r.participantid
) x
WHERE 
{firstName} 
AND {middleName}
AND {lastName} 
AND {SSN}
--x.FullName like {searchText} OR x.SSN like {searchText}
order by FullName
-- and CONCAT(r.participantid,r.programName) not in (SELECT CONCAT(participantId,waitingListName) from lodging.Reservation res )

END