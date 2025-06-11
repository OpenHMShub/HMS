SELECT h.firstName +' '+h.lastName as 'name',rs.ReferralStatusName,rt.ReferralTypeName as 'typeName',
	rl.Comment as 'Comment',rl.timeCreated,pr.programName,rl.userName  
FROM
	participant.ReferralLog rl INNER JOIN participant.Referral r on r.id = rl.ReferralId INNER JOIN participant.ReferralStatus rs on rs.id = rl.ReferralStatus_ID
	INNER JOIN participant.Participant p on p.id = r.ParticipantId
	INNER JOIN humans.Human h on h.id = p.humanId INNER JOIN participant.ReferralType rt on rt.id = r.Type_Id
	INNER JOIN shelter.WaitListPrograms wlp on wlp.id = r.ProgramId INNER JOIN interaction.Program pr on pr.id = wlp.programId
WHERE 
	rl.id = :referralId