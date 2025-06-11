UPDATE organization.ApplicantStatus 
SET 
	employerId = :employer_id
	,participantID = :participant_id
	,"position" = :position
	,appliedDate = :applied_date
	,interviewedDate = :interviewed_date
	,hiredDate = :hired_date
	,hiredState = :hired_state
	,appliedComment = :applied_comment  
    ,interviewedComment = :interviewed_comment
    ,hiredComment = :hired_comment
WHERE id = :row_id
