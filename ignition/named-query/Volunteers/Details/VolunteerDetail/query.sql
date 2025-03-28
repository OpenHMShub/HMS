SELECT 
H.firstName,
H.middleName,
H.lastName, 
H.phone,
H.email, 
H.dob, 
H.id, 
V.id as "volunteerId",
--H.gender,
H.congregation,
H.school,
H.employer,
H.street,
H.city,
H.state,
H.zipCode,
isNull((
	SELECT isnull(sum(DATEDIFF(hour, I.startDate, I.endDate)),0)
	from calendar.eventInstanceVolunteers IV
	left join calendar.eventInstances I on I.instanceID = IV.instanceID
	WHERE I.startDate < GETDATE()
	GROUP BY IV.volunteerID
	HAVING IV.volunteerID = V.id
),0) as "hours",
G.volunteerGroupName
FROM staff.Volunteer V
Inner join humans.Human H on V.humanId = H.id
left join staff.VolunteerGroup G on G.id = V.volunteerGroupId
WHERE V.id = :volunteerId;