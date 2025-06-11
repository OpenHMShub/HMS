SELECT * FROM
	(SELECT H.id, H.firstName, H.lastName, H.phone, H.email,
	H.dob, DATEDIFF(YEAR, H.dob, GETDATE()) AS age, V.id as volunteerId
	FROM humans.Human H
	INNER JOIN staff.Volunteer V ON H.id = V.humanId
	WHERE V.timeRetired IS NULL) Volunteers
WHERE (firstName LIKE CONCAT('%', :firstName , '%') OR firstName IS NULL)
AND (lastName LIKE CONCAT('%', :lastName , '%') OR lastName IS NULL)
AND (id = CASE :useHumanId 
	WHEN 'true' THEN  :humanId 
	ELSE id END OR id IS NULL)