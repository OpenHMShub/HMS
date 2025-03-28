SELECT first_name, middle_name, last_name
FROM humans.GroupMembership h
WHERE h.participant_id = :participantId