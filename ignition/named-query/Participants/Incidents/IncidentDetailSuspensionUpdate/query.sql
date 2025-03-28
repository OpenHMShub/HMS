UPDATE
	participant.Suspension 
SET
	suspensionTypeId = :suspension_type_id,
	suspensionTypeIdRevised = :suspension_type_id,
	Duration = :duration,
	DurationRevised = :duration,
	dateBegin = :dateBegin,
	dateEnd = :dateEnd,
	dateEndRevised = :dateEnd,
	reinstateRequired = :reinstateRequired, 
	suspensionNotes = :suspension_notes
WHERE
	incidentLogId = :incident_log_id