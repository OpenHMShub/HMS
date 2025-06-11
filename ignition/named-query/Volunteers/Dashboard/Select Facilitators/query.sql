---Volunteers/Dashboard/Select Facilitators--
SELECT 
	h.id as 'humanId',e.id as 'employeeId',f.id as 'facilitatorId',h.firstName + ' ' + h.lastName as 'Name',h.email as 'Email'
FROM 
	staff.Facilitator f LEFT JOIN staff.Employee e on e.id = f.employeeId LEFT JOIN humans.Human h on h.id = e.humanId
WHERE 
	f.timeRetired IS NULL AND e.timeRetired IS NULL AND h.timeRetired IS NULL and h.timeDeceased IS NULL