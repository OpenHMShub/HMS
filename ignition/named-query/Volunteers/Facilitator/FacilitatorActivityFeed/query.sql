Declare @facilitatorId as int = :facilitatorId;
with Activities as (
SELECT
	0 AS ID,
	'FacilitatorAdded' as CardType,
	F.timeCreated as Date
FROM staff.Facilitator F
Where F.id = @facilitatorId
union
SELECT
	I.instanceID AS ID,
	'EventCompleted' as CardType,	
	I.startDate as Date
FROM calendar.eventInstanceFacilitators eif
LEFT JOIN calendar.eventInstances I on I.instanceID = eif.instanceID
WHERE eif.facilitatorID = @facilitatorId and I.endDate < GETDATE()
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
Order by Date desc;