SELECT distinct f.facilityName
FROM Lodging.bedlog bl, lodging.bed b , lodging.Room r, lodging.facility f
WHERE bl.id =   :bedLogId AND bl.bedId = b.id AND b.roomId = r.id AND r.facilityId = f.id