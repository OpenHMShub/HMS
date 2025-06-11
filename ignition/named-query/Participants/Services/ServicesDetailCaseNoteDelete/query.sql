DELETE FROM
	 participant.CaseNotesServices 
WHERE
	  CaseNotesId = :note_id AND  ServicesId = :service_id 