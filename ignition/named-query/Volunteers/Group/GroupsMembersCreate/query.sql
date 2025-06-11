---Volunteers/Group/GroupsMembers---
SELECT H.id as "humanId", H.firstName, H.lastName, H.phone, H.email,
	H.dob, H.gender, DATEDIFF(YEAR, H.dob, GETDATE()) AS age, H.race
FROM staff.Volunteer V
Inner join humans.Human H on V.humanId = H.id
WHERE V.timeRetired is null and V.volunteerGroupId = :groupId