---Employers/Applicants/ApplicantsDetailsSelect---
SELECT
[organization].[ApplicantStatus].[id] as "row_id"
,CONCAT([humans].[Human].firstName,' ',[humans].[Human].middleName,' ',[humans].[Human].lastName) as 'participant_name'
,[organization].[ApplicantStatus].[participantId] as 'participant_id'
,[organization].[ApplicantStatus].[position] as 'position'
,[organization].[ApplicantStatus].[appliedDate] as 'applied_date'
,[organization].[ApplicantStatus].[interviewedDate] as 'interviewed_date'
,[organization].[ApplicantStatus].[hiredDate] as 'hired_date'

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

where employerId = :employerID