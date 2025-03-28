SELECT
	m.id, m.bin, m.createdOn, m.disposedByStaffEmployeeId, m.disposedOn, m.exitAction, m.exitedByStaffEmployeeId, m.exitedOn, 
	m.location, m.participantId, m.selectedMedications,  m.startOn, 
	case WHEN m.shelterId IS NULL THEN NULL 
	ELSE checkInDetails.facilityId END as shelterId,
	case WHEN m.shelterId IS NULL THEN NULL
	ELSE checkInDetails.facilityName END as shelterName,
	CONCAT(d.FirstName , ' ' , d.middleName, ' ' , d.lastName ) as participantName,
	CASE WHEN m.exitedByStaffEmployeeId IS NOT NULL THEN (SELECT CONCAT(h.firstName, ' ' , h.lastName) 
	FROM humans.human h , staff.Employee e WHERE e.id = m.exitedByStaffEmployeeId AND e.humanId = h.id)
	ELSE '' end as exitedBy,
	CASE WHEN m.disposedByStaffEmployeeId IS NOT NULL THEN (SELECT CONCAT(h.firstName, ' ' , h.lastName) 
	FROM humans.human h , staff.Employee e WHERE e.id = m.disposedByStaffEmployeeId AND e.humanId = h.id)
	ELSE '' end as disposedBy,
	checkInDetails.eventEnd as checkOutDate
FROM participant.MedicationBinsLog m 
INNER JOIN participant.Dashboard d ON m.participantId = d.ID
LEFT JOIN 
(
SELECT  eventStart, participantId, eventEnd , facilityId , facilityName FROM
(
SELECT  bl.eventStart, bl.participantId, bl.eventEnd , r.facilityId , f.facilityName,
row_number() OVER(PARTITION BY bl.participantId ORDER BY bl.eventStart DESC ) as rn
FROM lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f
		WHERE  bl.bedId = b.id and b.roomId = r.id and r.facilityId = f.id 
)x where rn=1		
		) checkInDetails
ON (m.participantId = checkInDetails.participantId )
WHERE
	(
		(:activityStatus = 0 AND m.exitAction IS NULL) -- 0 = Active Bins only
			OR
		(:activityStatus = 1 AND m.exitAction IS NOT NULL) -- 1 = Inactive / Expired Bins only
			OR
		(:activityStatus = 2) -- 2 = Active and Inactive Bins
	)
		AND
	(
		:searchFilter = ''
			OR
		 (
		 	:searchFilter != ''
		 		AND 
		 	(
		 		CONCAT(d.FirstName , ' ' , d.middleName, ' ' , d.lastName ) LIKE :searchFilter
		 	 		OR
		 	 	m.bin LIKE :searchFilter
		 	 		OR
		 	 	checkInDetails.facilityName LIKE :searchFilter
		 	)
		 )
	)
		AND
	(
		:daysAgoFilter = 0
			OR
	 	m.startOn > CAST(CAST(DATEADD(day, -1*:daysAgoFilter, GETDATE()) AS DATE) AS DATETIME)
	)
	AND
	(
		
		(:shelterStatus = 1 AND m.shelterId IS NULL) -- 1 = not in shelter
			OR
		(:shelterStatus = 2 AND m.shelterId IS NOT NULL) -- 2 = in shelter
			OR
		(:shelterStatus = -1 OR :shelterStatus IS NULL OR :shelterStatus = '')
		
	)
	AND
	(
		( :location = 'All' or :location IS NULL OR :location = '')
		OR
		(:location != 'All' AND :location IS NOT NULL AND :location != '' AND m.location = :location)
	)

ORDER BY
	startOn DESC