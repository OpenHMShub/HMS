SELECT
	ip.programName ,
	h.EntryDate,
	h.ExitDate,
	h.ParticipantID,
	h.id,
	h.ProgramID,
	case when h.ExitDate IS NULL then 'Active'
	ELSE 'InActive' end as activeStatus,
	CONCAT_WS(' ',d.FirstName,d.MiddleName,d.LastName) as 'Name',
	d.BirthDate,
	
  	COALESCE((
  		SELECT TOP 1 f.facilityName FROM
  		lodging.bedlog bl, lodging.reservation res, lodging.Bed b, lodging.Room r, lodging.Facility f
  		where bl.reservationId = res.id
  		and f.timeRetired is null
		and bl.bedId = b.id 
		and b.roomId = r.id 
		and r.facilityId = f.id
  		and res.programId = h.ProgramID 
  		and 
  		(((bl.eventStart >= h.EntryDate and bl.eventStart <= h.ExitDate) or
  		(bl.eventEnd >= h.EntryDate and bl.eventEnd <= h.ExitDate)) or 
  		((bl.eventEnd is null or bl.eventEnd = '') and bl.eventStart <= h.ExitDate) or
  		((h.ExitDate is NULL ) and bl.eventStart >= h.EntryDate))
  		ORDER BY bl.eventStart Desc
 
  		) , '')as shelterName
	
FROM
	 participant.ProgramsHistory h 
	 LEFT JOIN interaction.Program ip ON h.ProgramID = ip.id
	 LEFT JOIN participant.Dashboard d ON h.ParticipantID = d.ID
WHERE
	(h.ExitDate IS NULL OR DATEDIFF(hour, h.EntryDate, h.ExitDate) > 4) AND
	h.assignedStaffId is NULL 
ORDER BY h.EntryDate DESC