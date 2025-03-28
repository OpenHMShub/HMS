SELECT count(bl.id)
FROM lodging.Facility a, lodging.Bed b, lodging.BedLog bl , lodging.Room as r
where a.timeRetired is null and bl.eventEnd > GETDATE() and a.id = :shelterID and a.id = r.facilityId and r.id = b.roomId and b.id = bl.bedId
   