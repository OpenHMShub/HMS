---Employers/Applicants/ApplicantsDetailsSelect---
SELECT
MONTH([organization].[ApplicantStatus].[appliedDate]) as 'applied_month'

,CASE WHEN [organization].[ApplicantStatus].[appliedDate] is NULL THEN 0
ELSE 1
END AS "applied_state"

,[organization].[ApplicantStatus].[hiredState] as 'hired_state'

FROM [organization].[ApplicantStatus]

where employerId = :employerID