----Participants/Activities/ActivityFeed----
Declare @vendorId as int = :vendorId;

with Activities as (
SELECT
	0 AS ID
,	'VendorAdded' as CardType
,	[organization].[Vendor].timeCreated as Date
FROM [organization].[Vendor]
Where [organization].[Vendor].id = @vendorId
union
SELECT
	[organization].[VendorNotes].id AS ID
,	'Note' as CardType
,	[organization].[VendorNotes].timeCreated as Date
FROM [organization].[VendorNotes]
Where [organization].[VendorNotes].vendorId = @vendorId
union
SELECT
	[organization].[VendorContacts].id AS ID
,	'Contact' as CardType
,	[organization].[VendorContacts].timeCreated as Date
FROM [organization].[VendorContacts]
Where [organization].[VendorContacts].vendorId = @vendorId

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