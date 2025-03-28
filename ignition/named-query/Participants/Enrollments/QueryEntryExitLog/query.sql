SELECT 
	x.id, x.action, x.actionDate, x.username,
	CONCAT(h.firstname, ' ', h.lastName) as participantName,
	ip.programName as programName

FROM
  	participant.ProgramLog x  
	LEFT JOIN participant.participant p ON x.participantId = p.id
	LEFT JOIN humans.Human h ON h.id = p.humanId
	LEFT JOIN interaction.program ip ON x.programId = ip.id
WHERE 
	:startDate <= x.actionDate and :endDate >= x.actionDate
	AND ( :action IS NULL OR :action = '' OR x.action = :action)
	
	AND ( 
		:searchText IS NULL 
		OR :searchText = '' 
		OR ( h.firstName like :searchText)
		OR ( h.lastName like :searchText)
		OR ( x.action like :searchText)
		OR ( ip.programName like :searchText)
		)
	
ORDER BY 
	x.actionDate desc
