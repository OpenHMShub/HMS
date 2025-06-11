---Volunteers/Group/groupLeader---
SELECT top 1 humans.Human.firstName, humans.Human.lastName, humans.Human.phone, humans.Human.email
FROM staff.Volunteer
Inner join humans.Human on staff.Volunteer.humanId = Humans.Human.id
WHERE staff.Volunteer.isLeader = 1 and staff.Volunteer.volunteerGroupId = :groupId