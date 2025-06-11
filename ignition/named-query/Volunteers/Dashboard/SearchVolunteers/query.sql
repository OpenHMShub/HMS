SELECT top 100 *  FROM
	(SELECT V.id, H.firstName, H.lastName, H.email, DATEDIFF(YEAR, H.dob, GETDATE()) AS age
	FROM humans.Human H
	INNER JOIN staff.Volunteer V ON H.id = V.humanId
	WHERE V.timeRetired IS NULL) Volunteers
WHERE (firstName LIKE CONCAT('%', :firstName , '%') OR firstName IS NULL)
AND (lastName LIKE CONCAT('%', :lastName , '%') OR lastName IS NULL)