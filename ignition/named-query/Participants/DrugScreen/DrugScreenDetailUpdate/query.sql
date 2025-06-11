UPDATE	participant.DrugScreenLog
SET	employeeId = :employee_id,
	participantId = :participant_id,
	drugScreenTypeId = :drug_screen_type_id,
	providerId = :provider_id,
	passed = :passed,
	score = :score,
	gradeLevel = :grade_level,
	comments = :comments,
	timeCreated = :time_created,
	testDate = :test_date,
	drugscreenreasonid = :test_reason_id,
	userName =  :user_name
WHERE id = :row_id;