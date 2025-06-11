SELECT sum(DATEDIFF(minute, EI.startDate, EI.endDate)) as val
FROM calendar.eventInstanceVolunteers EIV
LEFT JOIN calendar.eventInstances EI on EI.instanceID = EIV.instanceID
WHERE YEAR(EI.startDate) = YEAR(GETDATE()) and EI.startDate < GETDATE() and EIV.validation = 1 and EIV.groupID is not null;