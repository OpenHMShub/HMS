SELECT h.firstName +' '+h.lastName as 'name',rt.ReferralTypeName as 'typeName',r.timeCreated,pr.programName 
FROM
	participant.Referral r 
	LEFT JOIN participant.Participant p on p.id = r.ParticipantId
	LEFT JOIN humans.Human h on h.id = p.humanId 
	LEFT JOIN participant.ReferralType rt on rt.id = r.Type_Id
	LEFT JOIN shelter.WaitListPrograms wlp on wlp.id = r.ProgramId 
	LEFT JOIN interaction.Program pr on pr.id = wlp.programId
WHERE 
	r.id = :referralId