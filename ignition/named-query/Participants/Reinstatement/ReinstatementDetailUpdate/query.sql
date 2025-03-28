UPDATE
	participant.ReinstatementLog
SET 
	suspensionTypeId = :suspension_type_id,
	duration = :duration,
	timeBegin = :time_begin,
	timeEnd = :time_end ,
	Comment = :comment
WHERE
	suspensionId = :suspension_id