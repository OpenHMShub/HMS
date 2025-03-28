---Shelter/Reservations/SelectParticipantsForReservation---
SELECT value, label
FROM
(
select p.id as value, concat(h.firstName , ' ', h.middleName, ' ', h.lastName) as label
from participant.Participant p, humans.Human h
where p.timeRetired is null and h.timeRetired is null and p.humanId = h.id
) x
ORDER BY label
