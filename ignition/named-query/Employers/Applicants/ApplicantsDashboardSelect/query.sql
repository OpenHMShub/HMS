DECLARE 
@applied AS bit = :applied
,@interviewed AS bit = :interviewed
,@hired AS BIT = :hired
,@not_hired AS BIT = :not_hired

---Employers/Applicants/ApplicantsDetailsSelect---
SELECT
[organization].[ApplicantStatus].[id] as "row_id"
,CONCAT([humans].[Human].firstName,' ',[humans].[Human].middleName,' ',[humans].[Human].lastName) as 'participant_name'
,[organization].[ApplicantStatus].[participantId] as 'participant_id'
,[organization].[ApplicantStatus].[employerId] as 'employer_id'
,[organization].[EmployerNew].[Employer Name] as 'employer_name'
,[organization].[ApplicantStatus].[position] as 'position'
--,[organization].[ApplicantStatus].[appliedDate] as 'applied_date'
,FORMAT([organization].[ApplicantStatus].[appliedDate], 'd', 'us') AS 'applied_date'
--,[organization].[ApplicantStatus].[interviewedDate] as 'interviewed_date'
,FORMAT([organization].[ApplicantStatus].[interviewedDate], 'd', 'us') AS 'interviewed_date'
--,[organization].[ApplicantStatus].[hiredDate] as 'hired_date'
,FORMAT([organization].[ApplicantStatus].[hiredDate], 'd', 'us') AS 'hired_date'

,CASE WHEN [organization].[ApplicantStatus].[appliedDate] is NULL THEN 0
ELSE 1
END AS "applied_state"

,CASE WHEN [organization].[ApplicantStatus].[interviewedDate] is NULL THEN 0
ELSE 1
END AS "interviewed_state"

,[organization].[ApplicantStatus].[hiredState] as 'hired_state'
,[organization].[ApplicantStatus].[appliedComment] as 'applied_comment'
,[organization].[ApplicantStatus].[interviewedComment] as 'interviewed_comment'
,[organization].[ApplicantStatus].[hiredComment] as 'hired_comment'

FROM [organization].[ApplicantStatus]
LEFT JOIN [participant].[Participant]
	ON [organization].[ApplicantStatus].participantId = [participant].[participant].id
LEFT JOIN [humans].[Human] 
	ON [participant].[participant].humanId = [humans].[Human].id
LEFT JOIN [organization].[EmployerNew]
	ON [organization].[ApplicantStatus].employerId = [organization].[EmployerNew].id

WHERE 
	((@applied=1 and [organization].[ApplicantStatus].[appliedDate] is not null) or (@applied=0 and ([organization].[ApplicantStatus].[appliedDate] is null or [organization].[ApplicantStatus].[appliedDate] is not null)))
	AND ((@interviewed=1 and [organization].[ApplicantStatus].[interviewedDate] is not null) or (@interviewed=0 and ([organization].[ApplicantStatus].[interviewedDate] is null or [organization].[ApplicantStatus].[interviewedDate] is not null)))
	AND ((@hired=1 and [organization].[ApplicantStatus].[hiredState]=1) OR (@hired=0 and ([organization].[ApplicantStatus].[hiredState] is null or [organization].[ApplicantStatus].[hiredState] is not null)))
	AND ((@not_hired=1 and [organization].[ApplicantStatus].[hiredState]=0) OR (@not_hired=0 and ([organization].[ApplicantStatus].[hiredState] is null or [organization].[ApplicantStatus].[hiredState] is not null)))