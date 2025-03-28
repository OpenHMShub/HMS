declare @date_range datetime
set @date_range = DATEADD(day, -2, CURRENT_TIMESTAMP)

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
	
  	COALESCE((
  		SELECT TOP 1 f.facilityName FROM
  		lodging.bedlog bl, lodging.reservation res, lodging.Bed b, lodging.Room r, lodging.Facility f
  		where bl.eventEnd is NULL and bl.reservationId = res.id
  		and f.timeRetired is null
		and bl.bedId = b.id 
		and b.roomId = r.id 
		and r.facilityId = f.id
  		and res.programId = h.ProgramID 
  		and bl.participantId = h.participantId
  		and bl.eventEnd is NULL
  		ORDER BY bl.eventStart Desc
 
  		) , '')as shelterName
	
FROM
	 participant.ProgramsHistory h 
	 LEFT JOIN interaction.Program ip ON h.ProgramID = ip.id
	 LEFT JOIN participant.Dashboard d ON h.ParticipantID = d.ID
WHERE
	(h.ExitDate IS NULL OR DATEDIFF(hour, h.EntryDate, h.ExitDate) > 4) AND
	h.assignedStaffId is NULL AND
 	(:allSelection = 0 OR 
 		(:allSelection = 1 and h.ExitDate IS NULL ) OR
 		(:allSelection = 2 and h.ExitDate IS NOT NULL) 
 	) 
 	AND (d.FirstName like  :firstName )
 	AND (d.MiddleName like  :middleName )
 	AND (d.LastName like  :lastName )
 	AND (:gpd_program_filter is NULL OR
 	:gpd_program_filter = '' OR
 	:gpd_program_filter = 'All Shelter Programs' OR 
 	(:gpd_program_filter = 'GPD Shelter Programs' AND (ip.programName in ('Veterans Hospital to Housing','Veterans Low Demand','Veterans Service Intensive'))) OR
 	(:gpd_program_filter = 'Non-Veteran GPD Shelter Programs' AND (
 		(ip.programName not in ('Veterans Hospital to Housing','Veterans Low Demand','Veterans Service Intensive')) AND
 		ip.isResidential = 1
 		))
 	)
)x
WHERE x.shelterName != ''
ORDER BY x.EntryDate DESC