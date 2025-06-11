SELECT count(*) 
FROM staff.Volunteer v 
WHERE v.timeRetired is NULL and v.volunteerGroupId is not NULL;