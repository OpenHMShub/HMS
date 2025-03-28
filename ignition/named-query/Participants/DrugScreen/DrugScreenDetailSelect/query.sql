---Participants/DrugScreen/DrugScreenDetailSelect
Declare @participantID as int = :participantID;

SELECT
	[participant].[DrugScreenLog].id AS 'id',
	[participant].[DrugScreenLog].participantId AS 'participant_id',
	[participant].[DrugScreenLog].drugScreenTypeId AS 'drug_screen_type_id',
	[participant].[DrugScreenLog].providerId AS 'provider_id',
	[participant].[DrugScreenLog].passed as 'passed',
	[participant].[DrugScreenLog].drugscreenreasonid as 'test_reason_id',
	[participant].[DrugScreenReason].DrugScreenReasonName  as 'test_reason',
	[participant].[DrugScreenLog].comments as 'comments',
	[participant].[DrugScreenLog].timeCreated AS 'time_created',
	[participant].[DrugScreenLog].TestDate AS 'test_date',
	[participant].[DrugScreenType].drugScreenTypeName as 'test_type',
	[participant].[DrugScreenLog].employeeId AS 'employee_id',
	CONCAT(e_employee.firstName,' ',e_employee.middleName,' ',e_employee.lastName) as 'employee_name',
	CONCAT(a_employee.firstName,' ',a_employee.middleName,' ',a_employee.lastName) as 'administered_by'

FROM
	
	[participant].[DrugScreenLog]
	INNER JOIN [participant].[Participant] on [participant].[DrugScreenLog].[participantId] = [participant].[Participant].id
	LEFT JOIN [humans].[Human] on [participant].[Participant].humanId = [humans].[Human].id
	LEFT JOIN [participant].[DrugScreenType] on [participant].[DrugScreenLog].[drugScreenTypeId] = [participant].[DrugScreenType].[id]
	LEFT JOIN [participant].[DrugScreenReason] on [participant].[DrugScreenLog].[drugscreenreasonid] = [participant].[DrugScreenReason].[id]

	LEFT JOIN staff.Employee e_staff ON [participant].[DrugScreenLog].employeeId = e_staff.Id
	LEFT JOIN [humans].[Human] e_employee ON e_staff.humanId = e_employee.id
		
	LEFT JOIN staff.Employee a_staff ON [participant].[DrugScreenLog].providerId = a_staff.Id
	LEFT JOIN [humans].[Human] a_employee ON a_staff.humanId = a_employee.id
	
WHERE 	[participant].[Participant].id = @participantID