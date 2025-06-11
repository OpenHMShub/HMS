Declare @employerName as nvarchar(max) = :orgName;
Declare @addr as nvarchar(max) = :addr;

Select
	[organization].[EmployerNew].[id], 
	[organization].[EmployerNew].[Employer Name] as orgName,
	[organization].[EmployerNew].[street]

From [organization].[EmployerNew]

WHERE [organization].[EmployerNew].timeRetired is null

AND (([Employer Name] like '%'+@employerName+'%' or @employerName = '')


OR	([street] like '%'+@addr+'%' or @addr = ''))
