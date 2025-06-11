/*---Employers/Activities/SelectSingleContact---*/
Declare @ContactID as int = :contactID  ;

SELECT
	CONCAT([organization].[ProviderContacts].firstName
,	' '
,	[organization].[ProviderContacts].lastName) as name
,	[organization].[ProviderContacts].phone as phone
,	[organization].[ProviderContacts].email as email
FROM [organization].[ProviderContacts]
Where [organization].[ProviderContacts].id = @ContactID
