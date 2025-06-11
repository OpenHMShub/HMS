SELECT 
	---[organization].[ApplicantStatus].id
	MONTH([organization].[ApplicantStatus].[appliedDate]) as 'applied_month'
FROM 
	[organization].[ApplicantStatus]
WHERE 
	[organization].[ApplicantStatus].employerId IN (SELECT convert(int, value) FROM string_split(:IdList, ','))
	and [organization].[ApplicantStatus].interviewedDate is not null