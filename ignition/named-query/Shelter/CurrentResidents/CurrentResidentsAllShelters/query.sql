---Shelter/CurrentResidents/CurrentResidentsAllShelters---
select table1.facilityId, table1.facilityName, table1.name, table1.eventStart, table1.eventEnd,
table1.bedName, table1.participantId, table1.id, table1.roomId, table1.roomName, table1.bedId, table1.gender, table1.race, table1.age,
case when table1.allResidential = 0 
then 
COALESCE(TableAssociatedPrograms.AssociatedPrograms, '') 
else 'All Residential Programs'
end as associatedProgram
from
(SELECT f.id as facilityId, f.facilityName, f.allResidential as allResidential, concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd,
b.bedName, bl.participantId, bl.id, r.id as roomId, r.roomName, b.id as bedId, p.gender, p.race, datediff(year, BirthDate, getdate())  as age
from
lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.Dashboard p
where f.timeRetired is null
and bl.bedId = b.id 
and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
and (((bl.eventStart >= :fromDate and bl.eventStart <= :toDate) or (bl.eventEnd >= :fromDate and bl.eventEnd <= :toDate)) or ((bl.eventEnd is null or bl.eventEnd = '') and bl.eventStart <= :toDate))
) table1
JOIN
(SELECT a.facilityId, STRING_AGG(b.ProgramName, ', ') AS AssociatedPrograms
FROM (SELECT distinct facilityId, associatedProgramId FROM lodging.FacilityAssociatedPrograms WHERE timeRetired is null) a LEFT JOIN interaction.Program b
ON a.associatedProgramId = b.id
GROUP BY a.facilityId) as TableAssociatedPrograms on TableAssociatedPrograms.facilityId = table1.facilityId