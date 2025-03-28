SELECT 
	---[organization].[ApplicantStatus].id
	MONTH([participant].[DrugScreenLog].timeCreated) as 'passed_month', [participant].[DrugScreenLog].passed as 'passed'
FROM 
	[participant].[DrugScreenLog]
WHERE 
	[participant].[DrugScreenLog].participantId IN (SELECT convert(int, value) FROM string_split(:IdList, ','))