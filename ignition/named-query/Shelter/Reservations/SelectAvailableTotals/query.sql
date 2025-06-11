SELECT 
	f.id,f.facilityName,facilityTotalBeds = COUNT(b.id),
	bedsNotReserved = (SELECT COUNT(b2.id) FROM lodging.Bed b2 LEFT JOIN lodging.Room r2 on r2.id = b2.roomId LEFT JOIN lodging.Facility f2 on f2.id = r2.facilityId
					WHERE b2.id NOT IN (SELECT br.bedId FROM lodging.Reservation br 
											WHERE br.timeRetired IS NULL AND (br.reservationEnd BETWEEN :startDate AND :endDate
												OR br.reservationStart BETWEEN :startDate AND :endDate))
					AND f2.id = f.id
					AND f2.timeRetired is NULL AND r2.timeRetired IS NULL AND b2.timeRetired IS NULL
				),
	bedsNotTaken = (SELECT COUNT(b3.id) FROM lodging.Bed b3 LEFT JOIN lodging.Room r3 on r3.id = b3.roomId LEFT JOIN lodging.Facility f3 on f3.id = r3.facilityId
					WHERE b3.id NOT IN (SELECT bl.bedId FROM lodging.BedLog bl 
											WHERE (bl.eventStart BETWEEN :startDate AND :endDate
												OR bl.eventEnd BETWEEN :startDate AND :endDate))
					AND f3.id = f.id
					AND f3.timeRetired is NULL AND r3.timeRetired IS NULL AND b3.timeRetired IS NULL
				),
	facilityTotalRooms = COUNT(DISTINCT b.roomId),
	roomsAllBedsNotReserved = (SELECT COUNT(r5.id) FROM lodging.Room r5 LEFT JOIN lodging.Facility f5 on f5.id = r5.facilityId
				WHERE r5.id NOT IN (SELECT b5.roomId FROM lodging.Reservation br  LEFT JOIN lodging.Bed b5 on b5.id = br.bedId 
										WHERE br.timeRetired IS NULL AND (br.reservationEnd BETWEEN :startDate AND :endDate
											OR br.reservationStart BETWEEN :startDate AND :endDate) AND b5.timeRetired IS NULL)
				AND f5.id = f.id
				AND f5.timeRetired is NULL AND r5.timeRetired IS NULL
				),
	roomsAllBedsNotTaken = (SELECT COUNT(r4.id) FROM lodging.Room r4 LEFT JOIN lodging.Facility f4 on f4.id = r4.facilityId
				WHERE r4.id NOT IN (SELECT b4.roomId FROM lodging.BedLog bl LEFT JOIN lodging.Bed b4 on b4.id = bl.bedId 
										WHERE (bl.eventStart BETWEEN :startDate AND :endDate
											OR bl.eventEnd BETWEEN :startDate AND :endDate) AND b4.timeRetired IS NULL)
				AND f4.id = f.id
				AND f4.timeRetired is NULL AND r4.timeRetired IS NULL
				)
								
FROM 
	lodging.Bed b LEFT JOIN lodging.Room r on r.id = b.roomId LEFT JOIN lodging.Facility f on f.id = r.facilityId
where 
	r.timeRetired is null 
	and b.timeRetired is null 
	and f.timeRetired is null
	AND (f.id = :facilityId OR NULLIF(:facilityId,'') IS NULL OR (ISNULL(:facilityId, 1)=1))
GROUP BY
	f.id,f.facilityName