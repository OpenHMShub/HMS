---Volunteers/Details/ActivityFeedQuery--
----Participants/Activities/ActivityFeed----
Declare @groupId as int = :groupId ;

with Activities as (
SELECT
	0 AS ID,
	'GroupAdded' as CardType,
	V.timeCreated as Date
FROM staff.VolunteerGroup V
Where V.id = @groupId
union
SELECT
	VN.id AS ID,
	'Note' as CardType,	
	VN.timeCreated as Date
FROM staff.VolunteerNotes VN
Where VN.groupId = @groupId
union
SELECT
	I.instanceID AS ID,
	'NoShow' as CardType,	
	I.startDate as Date
FROM calendar.eventInstanceVolunteers V
LEFT JOIN calendar.eventInstances I on I.instanceID = V.instanceID
WHERE V.groupID = @groupId and I.endDate < GETDATE() and V.validation = 0
union
--SELECT
--	l.id AS ID,	
--	'MembersAdded' as CardType,	
--	l.timestamp as Date
--FROM staff.VolunteerUpdateLog l
--Where l.volunteerId = @volunteerId
--union
SELECT
	I.instanceID AS ID,
	'EventCompleted' as CardType,	
	I.startDate as Date
FROM calendar.eventInstanceVolunteers V
LEFT JOIN calendar.eventInstances I on I.instanceID = V.instanceID
WHERE V.groupID = @groupId and I.endDate < GETDATE() and V.validation = 1
),

Headers AS (
Select distinct
	0 as ID
,	'Header' as CardType
,	DATEADD(millisecond, 997, DATEADD(second,59, DATEADD(minute, 59, DATEADD(hour, 23, DATEADD(Day,-1,DATEADD(month, DATEDIFF(month, -1, Activities.Date), 0)))))) AS Date
from Activities
),

TotalInfo as (
Select * from Headers
Union
Select * from Activities
)

Select Top 50 * from TotalInfo
Order by Date desc