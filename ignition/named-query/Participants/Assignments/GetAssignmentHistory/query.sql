SELECT * FROM
(
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
	'' as Shelter,
	CONCAT(staffH.firstName, ' ', staffH.lastName) as staffName,
  	CONCAT(assignerH.firstName, ' ', assignerH.lastName) as assignerName,
  	h.AssignedDate,
  	COALESCE((
  		SELECT TOP 1 f.facilityName FROM
  		lodging.bedlog bl, lodging.reservation res, lodging.Bed b, lodging.Room r, lodging.Facility f
  		where bl.reservationId = res.id
  		and f.timeRetired is null
		and bl.bedId = b.id 
		and b.roomId = r.id 
		and r.facilityId = f.id
  		and res.programId = h.ProgramID 
  		and bl.participantId = h.ParticipantID
  		and 
  		(((bl.eventStart >= h.EntryDate and bl.eventStart <= h.ExitDate) or
  		(bl.eventEnd >= h.EntryDate and bl.eventEnd <= h.ExitDate)) or 
  		((bl.eventEnd is null or bl.eventEnd = '') and bl.eventStart <= h.ExitDate) or
  		((h.ExitDate is NULL ) and bl.eventStart >= h.EntryDate))
  		ORDER BY bl.eventStart Desc
 
  		) , '')as shelterName,
  		h.assignedStaffId,
  		1 as Detail,
  		staffH.email as staffEmail
	
FROM
	 participant.ProgramsHistory h 
	 LEFT JOIN interaction.Program ip ON h.ProgramID = ip.id
	 LEFT JOIN participant.Dashboard d ON h.ParticipantID = d.ID
	 LEFT JOIN staff.Employee staff ON h.assignedStaffId = staff.id
  	 LEFT JOIN staff.Employee assigner ON h.AssignedBy  = assigner.id
  	 LEFT JOIN humans.Human staffH ON staff.humanId = staffH.id
  	 LEFT JOIN humans.Human assignerH ON assigner.humanId = assignerH.id

	 
WHERE
	(h.ExitDate IS NULL OR DATEDIFF(hour, h.EntryDate, h.ExitDate) > 4) AND
	h.assignedStaffId is not NULL and h.AssignedDate is not null AND 
 	(:allSelection = -1 OR 
 		(:allSelection = 1 and h.ExitDate IS NULL ) OR
 		(:allSelection = 0 and h.ExitDate IS NOT NULL) 
 	) AND
 	( :selectedStaff is NULL or  :selectedStaff = '' or :selectedStaff  = -1 or :selectedStaff = h.assignedStaffId) AND
 	( :selectedAssigner is NULL or :selectedAssigner = '' or :selectedAssigner = -1 OR :selectedAssigner = h.AssignedBy) AND
 	( :selectedProgram is NULL or :selectedProgram  = '' OR :selectedProgram = ip.programName) 
) x
WHERE 
 	( :selectedShelter is NULL or :selectedShelter = '' or x.shelterName = :selectedShelter)
 	AND x.Name != ''
 	AND
 	( :searchText is NULL or :searchText = ''  
 		or x.shelterName like :searchText or x.programName like :searchText
 		or x.Name like :searchText or x.staffName like :searchText or x.assignerName like :searchText)  	
ORDER BY x.EntryDate DESC