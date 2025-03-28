SELECT first_name, middle_name, last_name, REPLACE(CONCAT(first_name, ' ', middle_name, ' ', last_name), '  ', ' ') AS 'full_name'
FROM humans.GroupMembership h
WHERE h.participant_id = :participantId