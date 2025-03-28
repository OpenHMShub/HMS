--DECLARE 
--	 @dateRangeFrom datetime = ?
--	,@dateRangeTo datetime = ?
	
;WITH TableResidents as (SELECT f.id as facilityId, f.facilityName, f.allResidential as allResidential, concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd,
b.bedName, bl.participantId, bl.id as bedLogId, r.id as roomId, r.roomName, b.id as bedId, p.isActive,
CASE WHEN bl.exitDestinationId IS NULL THEN '' ELSE (SELECT destinationName FROM [lodging].[ExitDestination] where timeRetired is NULL 
AND id = bl.exitDestinationId) END AS ExitDestination,
COALESCE(bl.exitDestinationId, -1) AS exitDestinationId,
(SELECT RIGHT(hh.SSN, 4) FROM [participant].[Participant] pp, [humans].[Human] hh WHERE pp.id = p.[ID] AND pp.humanId = hh.id) as SSN,
p.gender, p.race, datediff(year, BirthDate, getdate())  as age
from
lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.HistoryDashboard p
where f.timeRetired is null 
and b.timeRetired is null
and r.timeRetired is null
and bl.bedId = b.id 
and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
and (((bl.eventStart >= :dateRangeFrom and bl.eventStart <= :dateRangeTo) or (bl.eventEnd >= :dateRangeFrom and bl.eventEnd <= :dateRangeTo)) or ((bl.eventEnd is null or bl.eventEnd = '') and bl.eventStart <= :dateRangeTo))
) ,
TableAssociatedPrograms as (SELECT bl.id, COALESCE(b.ProgramName , '') AS AssociatedPrograms
FROM lodging.BedLog bl LEFT JOIN lodging.Reservation r
ON bl.reservationId = r.id
LEFT JOIN interaction.Program b
ON r.programId = b.id
),
TableJoin as (
select distinct [TableResidents].facilityId, 
[TableResidents].isActive,
	[TableResidents].name, 
	[TableResidents].eventStart, 
	[TableResidents].eventEnd,
	[TableResidents].ExitDestination,
	[TableResidents].exitDestinationId,
	[TableResidents].gender, 
	[TableResidents].race,
	[TableResidents].age,
	[TableResidents].SSN,
	
	[TableAssociatedPrograms].AssociatedPrograms as associatedProgram,
	[TableResidents].facilityName, 
	[TableResidents].roomName,
	[TableResidents].bedName, 
	[TableResidents].participantId, 
	[TableResidents].bedLogId, 
	[TableResidents].roomId,  
	[TableResidents].bedId
	from [TableResidents]
	JOIN
	[TableAssociatedPrograms] ON [TableAssociatedPrograms].id = [TableResidents].bedLogId
	)
select DISTINCT [TableJoin].facilityId,
	[TableJoin].isActive, 
	[TableJoin].name, 
	[TableJoin].eventStart, 
	[TableJoin].eventEnd,
	[TableJoin].ExitDestination,
	[TableJoin].exitDestinationId,
	[TableJoin].gender, 
	[TableJoin].race, 
	[TableJoin].age,
	[TableJoin].associatedProgram,
	[TableJoin].facilityName,
	[TableJoin].roomName,
	[TableJoin].bedName, 
	[TableJoin].participantId, 
	[TableJoin].bedLogId, 
	[TableJoin].roomId,  
	[TableJoin].bedId,
	[TableJoin].SSN
	from [TableJoin]
	WHERE (1=1) 

ORDER BY [TableJoin].[facilityName]