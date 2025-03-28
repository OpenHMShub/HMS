SELECT
	
	ip.programName ,
	h.EntryDate,
	h.ExitDate,
	h.ParticipantID,
	h.id,
	h.ProgramID,
	case when h.ExitDate IS NULL then 'Active'
	ELSE 'InActive' end as activeStatus,
	CONCAT(staffH.firstName, ' ', staffH.lastName) as staffName
	
FROM
	 participant.ProgramsHistory h 
	 
	 LEFT JOIN interaction.Program ip ON h.ProgramID = ip.id
	 LEFT JOIN staff.Employee staff ON h.assignedStaffId = staff.id
	 LEFT JOIN humans.Human staffH ON staff.humanId = staffH.id
WHERE
	h.id =  :recordId 