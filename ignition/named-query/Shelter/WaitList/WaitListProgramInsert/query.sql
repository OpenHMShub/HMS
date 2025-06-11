INSERT INTO  shelter.WaitListPrograms 
	( 
		programId,
		timeCreated 
	)
VALUES
	(
	 :program_id,
	 GetDate()
	 )