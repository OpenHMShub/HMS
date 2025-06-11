---Volunteers/Notes/NotesDashboardSelect---
SELECT
	[staff].[VolunteerNotes].id AS 'note_id',
	[staff].[VolunteerNotes].Category AS 'category',
	[staff].[VolunteerNotes].Note as 'note',
	[staff].[VolunteerNotes].timeCreated AS 'time_created',
	[staff].[VolunteerNotes].employeeId AS 'employee_id',
	CONCAT(h_employee.firstName,' ',h_employee.middleName,' ',h_employee.lastName) as 'employee_name'
FROM
	[staff].[VolunteerNotes]
	LEFT JOIN staff.V
	ON [staff].[VolunteerNotes].employeeId = [staff].[Employee].Id
	LEFT JOIN [humans].[Human] h_employeesdsd
	ON [staff].[Employee].humanId = h_employee.id
