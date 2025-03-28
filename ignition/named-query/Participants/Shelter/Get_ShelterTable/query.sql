SELECT * FROM
(
SELECT
	 pt.id  as 'participant_id',
	 f.facilityName as 'facility_name',
	 rm.facilityId  as 'facility_id',
	 b.roomId as 'room_id',
	 rm.roomName as 'room_name',
	 bl.bedId as 'bed_id',
	 b.bedName as 'bed_name', 
	 bl.eventStart as 'check_in',
	 bl.eventEnd as 'check_out',
	 pr.id as 'associated_program_id',
	 pr.ProgramName as 'associated_program_name',
	 CASE WHEN pt.timeRetired is NULL then 1 ELSE 0 END as 'is_active',
	 CASE WHEN bl.exitDestinationId IS NULL THEN '' ELSE (SELECT destinationName FROM [lodging].[ExitDestination] where timeRetired is NULL 
AND id = bl.exitDestinationId) END AS ExitDestination,
'' as 'congregation',
'shelterRecord' as recordType,
-1 as 'congregation_id'
FROM
	[participant].[Participant] pt
	INNER JOIN [lodging].[BedLog] bl ON bl.participantId = pt.id
	LEFT JOIN [lodging].[Bed] b ON bl.bedId = b.id
	LEFT JOIN [lodging].[Room] rm ON b.roomId = rm.id
	LEFT JOIN [lodging].[Facility] f ON rm.facilityId = f.id
	LEFT JOIN [lodging].[Reservation] res ON bl.reservationId = res.id
	LEFT JOIN [interaction].[Program] pr ON res.programId = pr.id
	
WHERE pt.id =   :participantId 
AND  ( :allSelection = 1 OR :allSelection = 2)
AND  ( :shelter IS NULL OR :shelter = '' OR ((:shelter != 'All Guest House' and facilityName = :shelter) OR (:shelter = 'All Guest House' and facilityName NOT IN ('532 Apartments','705 Apartments'))))
AND ( :program IS NULL OR :program = '' OR pr.ProgramName = :program )

UNION ALL

SELECT 
	 d.id  as 'participant_id',
	 '' as 'facility_name',
	 ''  as 'facility_id',
	 '' as 'room_id',
	 '' as 'room_name',
	 '' as 'bed_id',
	 '' as 'bed_name', 
     CASE WHEN s.dayOfYear > 90 THEN DateAdd(DAY,s.dayOfYear,DateFromParts(CAST(LEFT(ss.seasons,4) AS INT)-1,12,31)) 
      ELSE DateAdd(DAY,s.dayOfYear,DateFromParts(CAST(RIGHT(ss.seasons,4) AS INT)-1,12,31)) 
      END as 'check_in',
      CASE WHEN s.dayOfYear > 90 THEN DateAdd(day, 1, DateAdd(DAY,s.dayOfYear,DateFromParts(CAST(LEFT(ss.seasons,4) AS INT)-1,12,31)) )
      ELSE DateAdd(day, 1, DateAdd(DAY,s.dayOfYear,DateFromParts(CAST(RIGHT(ss.seasons,4) AS INT)-1,12,31)) )
      END as 'check_out',
	 '' as 'associated_program_id',
	 '' as 'associated_program_name',
	 d.isActive as 'is_active',
	 ''as ExitDestination,
      l.locationName  as 'congregation',
      'wsRecord' as recordType,
      l.id as 'congregation_id'

  FROM [shelter].[ScheduleParticipant] s, shelter.Seasons ss,
  participant.Dashboard d, shelter.Location l 
  WHERE s.timeRetired is NULL AND s.seasonId = ss.id 
  AND s.participantId = d.id 
 
  AND s.locationId = l.id
  
  AND  s.participantId =  :participantId 
  AND  ( :allSelection = 1 OR :allSelection = 3)
  AND ( :congregation IS NULL OR :congregation = '' OR l.locationName =  :congregation )
  
) x
WHERE  (
(x.check_in >=  :dateRangeFrom  AND x.check_in <=  :dateRangeTo )
OR
(x.recordType = 'shelterRecord' AND (x.check_out IS NULL OR (x.check_out >=  :dateRangeFrom  AND x.check_out <=  :dateRangeTo )))
)
AND
(	x.facility_name like   :search_text OR
	x.room_name like   :search_text OR
	x.bed_name like   :search_text OR
	x.ExitDestination like   :search_text OR
	x.congregation like  :search_text
)
order by x.check_in desc