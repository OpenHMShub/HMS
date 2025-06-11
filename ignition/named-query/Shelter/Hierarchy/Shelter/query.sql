SELECT 
	f.id as 'facilityId',f.facilityName as 'Shelter',f.beds as 'Total Beds',
	(SELECT COUNT(DISTINCT bl.bedId) FROM lodging.BedLog bl LEFT JOIN lodging.Bed b on b.id=bl.bedId
	LEFT JOIN lodging.Room ro on ro.id = b.roomId 
	WHERE ro.facilityId = f.id and 
		((bl.eventStart BETWEEN :timeStart and :timeEnd) OR (bl.eventEnd BETWEEN :timeStart and :timeEnd))
		) as 'Beds Taken',
	(SELECT COUNT(DISTINCT r.bedId) FROM lodging.Reservation r LEFT JOIN lodging.Bed b on b.id=r.bedId
	LEFT JOIN lodging.Room ro on ro.id = b.roomId 
	WHERE ro.facilityId = f.id and 
		((r.reservationStart BETWEEN :timeStart and :timeEnd) OR (r.reservationEnd BETWEEN :timeStart and :timeEnd))
		and r.timeRetired IS NULL) as 'Beds Reserved',
	f.rooms as 'Total Rooms',
	ft.facilityTypeName as 'Shelter Type'
FROM
	lodging.Facility f
	LEFT JOIN lodging.FacilityType ft on ft.id = f.facilityTypeId
WHERE 
	f.timeRetired IS NULL
	