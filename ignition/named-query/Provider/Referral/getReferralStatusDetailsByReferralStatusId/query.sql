SELECT h.firstName +' '+h.lastName as 'name',rs.ReferralStatusName,rt.ReferralTypeName as 'typeName',
	rl.Comment as 'Comment',rl.timeCreated,pr.programName,rl.userName  
FROM
	participant.ReferralLog rl 
	LEFT JOIN participant.Referral r on r.id = rl.ReferralId 
	LEFT JOIN participant.ReferralStatus rs on rs.id = rl.ReferralStatus_ID
	LEFT JOIN participant.Participant p on p.id = r.ParticipantId
	LEFT JOIN humans.Human h on h.id = p.humanId 
	LEFT JOIN participant.ReferralType rt on rt.id = r.Type_Id
	LEFT JOIN shelter.WaitListPrograms wlp on wlp.id = r.ProgramId 
	LEFT JOIN interaction.Program pr on pr.id = wlp.programId
WHERE 
	rl.id = :referralId