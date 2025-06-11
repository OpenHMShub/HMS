SELECT id, volunteerId, description, [timestamp]
FROM HMSOps.staff.VolunteerUpdateLog
WHERE id = :id;
