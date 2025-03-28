UPDATE	participant.CaseNotes
SET participantId = :participant_id,
	employeeId = :employee_id, 
	Note = :note,
	HMIS = :hmis, 
    userName = :user_name,
    startTime = :startTime,
    endTime = :endTime,
    notifyStaffId = :notifyStaffId
WHERE id = :row_id;
