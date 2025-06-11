Declare @providerName as nvarchar(max) = :providerName;
Declare @addr as nvarchar(max) = :addr;


Select
	[organization].[Provider].id,
	[organization].[Provider].organizationId, 
	[organization].[Provider].providerName,
	[organization].[Provider].street

From [organization].[Provider]

Where [organization].[Provider].timeRetired is null

And (([organization].[Provider].providerName like '%'+@providerName+'%' or @providerName = '')


OR	([organization].[Provider].street like '%'+@addr+'%' or @addr = ''))
