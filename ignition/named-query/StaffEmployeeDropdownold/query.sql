SELECT 
	employeeId as id,
	REPLACE(CONCAT(firstName, ' ', middleName, ' ', lastName), '  ', ' ') as name
FROM staff.vwEmployeeDetails
WHERE humanId > 1