SELECT *
FROM staff.VolunteerTask T
WHERE T.volunteerJobId = :jobId and timeRetired is NULL;