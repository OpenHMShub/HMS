SELECT 
n.id, 
n.category, 
n.note, 
n.timeCreated, 
n.userName, 
n.noteDate, 
n.volunteerId, 
n.groupId,
CASE
	WHEN n.volunteerId IS NOT NULL THEN 
		CONCAT(h.firstName,' ',h.lastName)
	WHEN n.groupId  IS NOT NULL THEN
		vg.volunteerGroupName
	ELSE ''
END as "name"
FROM HMSOps.staff.VolunteerNotes n
LEFT JOIN staff.Volunteer v on v.id = n.volunteerId
LEFT JOIN humans.Human h on h.id = v.humanId
LEFT JOIN staff.VolunteerGroup vg on vg.id = n.groupId;