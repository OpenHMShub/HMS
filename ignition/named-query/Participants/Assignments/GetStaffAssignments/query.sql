---Participants/EmployeeDropdownList---
SELECT
	e.id,
	CONCAT_WS(' ',h.firstName, h.middleName, h.lastName) as 'employee_name',
	(
	   SELECT COALESCE(COUNT(id), 0) FROM participant.ProgramsHistory WHERE 
	   (ExitDate IS NULL OR DATEDIFF(hour, EntryDate, ExitDate) > 4)
	   AND  assignedStaffId = e.id ) as 'no_of_active_assignments'
FROM
	staff.Employee e
	INNER JOIN humans.Human h on e.humanId = h.id AND e.timeRetired is NULL AND e.assignments = 1
	ORDER BY 'employee_name'