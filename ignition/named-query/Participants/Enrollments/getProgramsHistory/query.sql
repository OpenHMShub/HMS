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
	h.ParticipantID =  :participantID AND
	(h.ExitDate IS NULL OR DATEDIFF(hour, h.EntryDate, h.ExitDate) > 4) AND
	( 	:startDate IS NULL OR 
		:endDate IS NULL OR
 		(h.EntryDate between :startDate and :endDate ) OR
 	 	(h.ExitDate between :startDate and :endDate)
 	) AND
 	(:allSelection = 0 OR 
 	(:allSelection = 1 and h.ExitDate IS NULL) OR
 	(:allSelection = 2 and h.ExitDate IS NOT NULL) 
 	)	
ORDER BY h.EntryDate DESC