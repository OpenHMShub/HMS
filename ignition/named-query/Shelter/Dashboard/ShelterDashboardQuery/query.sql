SELECT table1.id, table1.ShelterName, table1.ShelterType,table1.address ,table1.zipCode, table1.beds, table1.phone,
COALESCE(TableReservations.reservations , 0) as noOfReservations , 
case when table1.allResidential = 0 
then 
COALESCE(TableAssociatedPrograms.AssociatedPrograms, '') 
else 'All Residential Programs'
end as associatedProgram, 'None' as WaitingList,
COALESCE(TableCheckins.checkins , 0) as noOfCheckins
FROM
(SELECT a.id as id, a.facilityName as ShelterName, b.facilityTypeName as ShelterType, concat (a.street, ' ', a.city, ' ', a.state) as address,
a.zipCode as zipCode, a.beds as beds, a.rooms as rooms, a.phone as phone, a.allResidential as allResidential
FROM lodging.Facility a, lodging.FacilityType b 
where a.timeRetired is null and a.facilityTypeId = b.id ) table1
LEFT OUTER JOIN (SELECT a.id as id, count(res.id) as reservations
FROM lodging.Facility a, lodging.Room r, lodging.Bed b, lodging.Reservation res 
where a.timeRetired is null and res.timeRetired is null and a.id = r.facilityId and b.roomId = r.id and res.bedId = b.id and res.reservationEnd > GETDATE()
group by a.id) as TableReservations ON TableReservations.id = table1.id
LEFT OUTER JOIN (SELECT a.id as id, count(bedlogs.id) as checkins
FROM lodging.Facility a, lodging.Room r, lodging.Bed b, lodging.BedLog bedlogs 
where a.timeRetired is null and a.id = r.facilityId and b.roomId = r.id and bedlogs.bedId = b.id  and bedlogs.eventEnd is null --> GETDATE()
group by a.id) as TableCheckins ON TableCheckins.id = table1.id
JOIN
(SELECT a.facilityId, STRING_AGG(b.ProgramName, ', ') AS AssociatedPrograms
FROM (SELECT distinct facilityId, associatedProgramId FROM lodging.FacilityAssociatedPrograms WHERE timeRetired is null) a LEFT JOIN interaction.Program b
ON a.associatedProgramId = b.id
GROUP BY a.facilityId) as TableAssociatedPrograms on TableAssociatedPrograms.facilityId = table1.id