INSERT INTO participant.CaseNotesEditLog ( participantId, actionDate, actionBy, action, 
caseNoteId, oldStartTime, oldEndTime, newStartTime, newEndTime,userName) VALUES
( :participant_id ,CURRENT_TIMESTAMP, :employee_id, :action, :case_note_id, :old_start_time, 
:old_end_time, :new_start_time, :new_end_time, :user_name )