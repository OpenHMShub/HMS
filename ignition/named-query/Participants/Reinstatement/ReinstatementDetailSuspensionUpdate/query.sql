UPDATE participant.Suspension 

SET	DurationRevised = :duration,
	suspensionTypeIdRevised = :suspension_type_id,
	dateEndRevised  = :time_end


WHERE id = :suspension_id;
