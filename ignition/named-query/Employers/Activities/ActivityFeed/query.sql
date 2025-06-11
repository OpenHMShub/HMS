----Participants/Activities/ActivityFeed----
Declare @employerId as int = :employerId;

with Activities as (
SELECT
	0 AS ID
,	'EmployerAdded' as CardType
,	[organization].[EmployerNew].timeCreated as Date
FROM [organization].[EmployerNew]
Where [organization].[EmployerNew].id = @employerId
union
SELECT
	[organization].[EmployerNotes].id AS ID
,	'Note' as CardType
,	[organization].[EmployerNotes].timeCreated as Date
FROM [organization].[EmployerNotes]
Where [organization].[EmployerNotes].employerId = @employerId
union
SELECT
	[organization].[EmployerContacts].id AS ID
,	'Contact' as CardType
,	[organization].[EmployerContacts].timeCreated as Date
FROM [organization].[EmployerContacts]
Where [organization].[EmployerContacts].employerId = @employerId
union
SELECT
	[organization].[ApplicantStatus].id AS ID
,	'Applied' as CardType
,	[organization].[ApplicantStatus].appliedDate as Date
FROM [organization].[ApplicantStatus]
Where [organization].[ApplicantStatus].employerId = @employerId AND [organization].[ApplicantStatus].appliedDate IS NOT NULL
union
SELECT
	[organization].[ApplicantStatus].id AS ID
,	'Interviewed' as CardType
,	[organization].[ApplicantStatus].interviewedDate as Date
FROM [organization].[ApplicantStatus]
Where [organization].[ApplicantStatus].employerId = @employerId AND [organization].[ApplicantStatus].interviewedDate IS NOT NULL
union
SELECT
	[organization].[ApplicantStatus].id AS ID
,	'Hired' as CardType
,	[organization].[ApplicantStatus].hiredDate as Date
FROM [organization].[ApplicantStatus]
Where [organization].[ApplicantStatus].employerId = @employerId AND [organization].[ApplicantStatus].hiredDate IS NOT NULL AND [organization].[ApplicantStatus].hiredState = 1
union
SELECT
	[organization].[ApplicantStatus].id AS ID
,	'NotHired' as CardType
,	[organization].[ApplicantStatus].hiredDate as Date
FROM [organization].[ApplicantStatus]
Where [organization].[ApplicantStatus].employerId = @employerId AND [organization].[ApplicantStatus].hiredDate IS NOT NULL AND [organization].[ApplicantStatus].hiredState = 0
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