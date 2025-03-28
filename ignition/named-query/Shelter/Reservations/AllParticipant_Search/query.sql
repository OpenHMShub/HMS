---Shelter/Reservations/SelectParticipantsForReservation---
SELECT id, firstName,middleName,lastName,FullName,SSN
FROM
(
select p.id as id,
ISNULL(h.firstName,'') as firstName,
ISNULL(h.middleName,'') as middleName,
ISNULL(h.lastName,'') as lastName,
RIGHT(h.SSN, 4) as SSN,
concat(h.firstName , ' ', h.middleName, ' ', h.lastName) as FullName
from participant.Participant p, humans.Human h
where p.timeRetired is null and h.timeRetired is null and p.humanId = h.id
) x
WHERE 
{firstName} 
AND {middleName}
AND {lastName} 
AND {SSN}
--x.FullName like {searchText} OR x.SSN like {searchText}
ORDER BY FullName
