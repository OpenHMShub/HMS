SELECT participantData.*
	, (select concat(firstName,case when middleName!='' then ' ' else ''end,middleName,case when lastName!='' then ' ' else ''end,lastName) from humans.Human where id = (select humanId from [staff].[Employee] where id =participantData.staffId)) as 'staff'
	, (select concat(firstName,case when middleName!='' then ' ' else ''end,middleName,case when lastName!='' then ' ' else ''end,lastName) from humans.Human where id = (select humanId from [staff].[Employee] where id =participantData.assignerId)) as 'assigner'
	, (select email from humans.Human where id = (select humanId from [staff].[Employee] where id =participantData.staffId)) as 'staffEmail'
FROM (
		select 
			bl.*, concat(p.firstName,case when p.middleName!='' then ' ' else ''end,p.middleName,case when p.lastName!='' then ' ' else ''end,p.lastName) as 'pname', f.facilityName
			,(select [assignedStaffId] from participant.ProgramsHistory h where bl.participantId = h.ParticipantID and res.programId = h.ProgramID and (((bl.eventStart >= h.EntryDate and bl.eventStart <= h.ExitDate) or (bl.eventEnd >= h.EntryDate and bl.eventEnd <= h.ExitDate)) or ((bl.eventEnd is null or bl.eventEnd = '') and bl.eventStart <= h.ExitDate) or ((h.ExitDate is NULL ) and bl.eventStart >= h.EntryDate))) as 'staffId'
			,(select [AssignedBy] from participant.ProgramsHistory h where bl.participantId = h.ParticipantID and res.programId = h.ProgramID and (((bl.eventStart >= h.EntryDate and bl.eventStart <= h.ExitDate) or (bl.eventEnd >= h.EntryDate and bl.eventEnd <= h.ExitDate)) or ((bl.eventEnd is null or bl.eventEnd = '') and bl.eventStart <= h.ExitDate) or ((h.ExitDate is NULL ) and bl.eventStart >= h.EntryDate))) as 'assignerId'
		from 
			lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.Dashboard p, lodging.reservation res--, participant.ProgramsHistory h 
		where 
			f.timeRetired is null
			and bl.bedId = b.id 
			and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id and bl.reservationId = res.id
			and f.facilityName = 'Welcome Dorm' 
			and bl.eventEnd is null
	 		and {dateRange}
	) participantData