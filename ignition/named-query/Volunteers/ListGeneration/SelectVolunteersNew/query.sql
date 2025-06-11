---Volunteers/ListGeneration/SelectVolunteers---
SELECT * FROM
	(SELECT 
	H.id, 
	H.firstName, 
	H.lastName, 
	H.phone, 
	H.email,
	H.dob, 
	DATEDIFF(YEAR, ISNULL(H.dob, GETDATE()), DATEADD(year, -1, GETDATE())) AS age, 
	v.volunteerGroupId,
	v.status,
	va.availabilityType, 
	va.availabilityTypeName,
	va.startDate,
	va.endDate
	FROM humans.Human H
	INNER JOIN staff.Volunteer V ON H.id = V.humanId
	LEFT JOIN staff.VolunteerAvailability va on va.id = V.id 
	LEFT JOIN calendar.eventInstanceVolunteers eiv on eiv.volunteerID = v.id
	LEFT JOIN calendar.eventInstanceFacilitators eif on eif.instanceID = eiv.instanceID 
	LEFT JOIN staff.VolunteerSkills vs on vs.volunteerId = v.id
	
	WHERE V.timeRetired IS NULL and
		{skills} and 
		{facilitator}
	) Volunteers
WHERE (firstName LIKE CONCAT('%', :firstName , '%') OR firstName IS NULL)
AND (lastName LIKE CONCAT('%', :lastName , '%') OR lastName IS NULL)
AND ((age >= :ageAbove AND age <= :ageBelow ) OR age IS NULL)
AND (volunteerGroupId = CASE  :useGroup 
	WHEN 'true' THEN  :groupId 
	ELSE volunteerGroupId END)