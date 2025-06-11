SELECT h.firstName +' '+h.lastName as 'name',rt.ReferralTypeName as 'typeName',r.timeCreated,pr.programName 
FROM
	participant.Referral r INNER JOIN participant.Participant p on p.id = r.ParticipantId
	INNER JOIN humans.Human h on h.id = p.humanId INNER JOIN participant.ReferralType rt on rt.id = r.Type_Id
	INNER JOIN shelter.WaitListPrograms wlp on wlp.id = r.ProgramId INNER JOIN interaction.Program pr on pr.id = wlp.programId
WHERE 
	r.id = :referralId