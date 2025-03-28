INSERT INTO	participant.CaseNotesTypes
	(
	CaseNotesId,
	CaseNoteTypeID,
	timeCreated
	)
VALUES
	(
 	:case_note_id, 
  	:case_note_type_id,
  	GETDATE()
	)