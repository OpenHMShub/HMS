SELECT x.id, x.reservationId, x.bedLogId, x.action, x.actionTime, x.employeeId, x.userName, 
x.bedId , x.participantId, CONCAT(d.FirstName, ' ', d.middleName, ' ' , d.lastName) as participantName , bed.bedName, room.roomName, f.facilityName, 
CASE WHEN x.employeeId = -1 THEN x.userName
ELSE CONCAT(h.firstname, ' ', h.lastName) END as staffName
FROM
 lodging.AuditLog x JOIN participant.Dashboard d ON x.participantId = d.id 
JOIN lodging.Bed bed ON x.bedId = bed.id
LEFT JOIN lodging.room room ON bed.roomId = room.id
LEFT JOIN lodging.Facility f ON room.facilityId = f.id
LEFT JOIN staff.Employee staff ON x.employeeId = staff.id
LEFT JOIN humans.Human h ON h.id = staff.humanId
WHERE :startDate <= x.actionTime and :endDate >= x.actionTime
AND ( :action IS NULL OR :action = '' OR x.action = :action)
AND ( :shelter IS NULL OR :shelter = '' OR f.facilityName = :shelter)
AND ( :staffId IS NULL OR x.employeeId = :staffId )
AND ( 
:searchText IS NULL 
OR :searchText = '' 
OR ( h.firstName like :searchText)
OR ( h.lastName like :searchText)
OR ( f.facilityName like :searchText)
OR ( x.action like :searchText)
OR ( d.firstName like :searchText)
OR ( d.lastName like :searchText)
OR ( bed.bedName like :searchText)
OR (room.roomName like :searchText)
)
ORDER BY x.actionTime desc
