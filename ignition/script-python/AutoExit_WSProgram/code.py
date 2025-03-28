def auto_exit_ws_program():
	## exit all participant's program 
	path = 'Participants/Enrollments/ExitWinterShelterProgram'
	system.db.runNamedQuery(path)
