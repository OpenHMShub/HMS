SELECT count(id) as cnt
FROM calendar.eventInstanceVolunteers IV
WHERE IV.volunteerID = :volunteerId and IV.validation = 1