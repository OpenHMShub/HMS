----WinterShelter/Activities/ActivityFeed----
DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());

with Activities as (
SELECT
	id as ID,
	locationId as CongregationID,
	activityType as CardType,
	activityDescription as ActivityDesc,
	timeCreated  as Date, -- FORMAT (timeCreated, 'MMM. dd yyyy, hh:mm tt')
	referenceId as RefferenceID
FROM 
	shelter.ActivityLog
WHERE
	locationId = :locationId
AND 
	timeCreated between @activity_start and @activity_end
--ORDER BY
--	timeCreated DESC	
),

Headers AS (
Select distinct
	0 as ID
,	'' as CongregationID
,	'Header' as CardType
,	''  as ActivityDesc
,	DATEADD(Day,-1,DATEADD(month, DATEDIFF(month, -1, Activities.Date), 0)) AS Date
,	''  as RefferenceID
from Activities
),

TotalInfo as (
Select * from Activities
Union
Select * from Headers
)

Select * from TotalInfo
Order by Date desc