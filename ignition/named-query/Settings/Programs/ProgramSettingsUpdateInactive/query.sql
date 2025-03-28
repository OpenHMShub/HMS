UPDATE	interaction.Program 
SET	programName = :program_name,
 	programDescription = :program_desc,
 	autoEnroll = :autoEnroll,
	timeCreated = :time_created,
 	timeRetired =  :time_retired,
 	isResidential = :isResidential
WHERE id = :program_id;