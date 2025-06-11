---Employers/Applicants/ApplicantsDetailsSelect---
SELECT

CASE WHEN [organization].[ApplicantStatus].[appliedDate] is NULL THEN 0
ELSE 1
END AS "applied_state"

, [organization].[ApplicantStatus].[hiredState] AS 'hired_state'

FROM [organization].[ApplicantStatus]

WHERE 
	[organization].[ApplicantStatus].employerId IN (SELECT convert(int, value) FROM string_split(:IdList, ','))