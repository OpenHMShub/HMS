INSERT INTO	interaction.Program 
	(
 	programName,
 	programDescription,
 	autoEnroll,
 	timeCreated,
 	isResidential
 	
	)
VALUES
	( 
	:program_name,
	:program_desc,
	:autoEnroll,
	:time_created,
	:isResidential
	)