SELECT 
	id, programName 
FROM
	interaction.Program
WHERE 
	 autoEnroll = 1
	 AND
	  timeRetired is null