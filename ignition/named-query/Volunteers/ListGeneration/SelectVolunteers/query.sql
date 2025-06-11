---Volunteers/ListGeneration/SelectVolunteers---
SELECT * FROM
	(SELECT H.id, H.firstName, H.lastName, H.phone, H.email,
	H.dob, H.gender, DATEDIFF(YEAR, ISNULL(H.dob, GETDATE()), DATEADD(year, -1, GETDATE())) AS age, H.race, v.volunteerGroupId
	FROM humans.Human H
	INNER JOIN staff.Volunteer V ON H.id = V.humanId
	WHERE V.timeRetired IS NULL) Volunteers
WHERE (firstName LIKE CONCAT('%', :firstName , '%') OR firstName IS NULL)
AND (lastName LIKE CONCAT('%', :lastName , '%') OR lastName IS NULL)
AND ((age >= :ageAbove AND age <= :ageBelow ) OR age IS NULL)
AND (gender = CASE  :useGender 
	WHEN 'true' THEN  :gender 
	ELSE gender END OR gender IS NULL)
AND (volunteerGroupId = CASE  :useGroup 
	WHEN 'true' THEN  :groupId 
	ELSE volunteerGroupId END)