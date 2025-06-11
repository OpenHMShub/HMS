SELECT 
	[organization].[ApplicantStatus].id
FROM 
	[organization].[ApplicantStatus]
WHERE 
	[organization].[ApplicantStatus].employerId IN (SELECT convert(int, value) FROM string_split(:IdList, ','))
	and [organization].[ApplicantStatus].hiredState = 0