/*---Employers/Activities/SelectSingleContact---*/
Declare @ContactID as int = :contactID  ;

SELECT
	CONCAT([organization].[EmployerContacts].firstName
,	' '
,	[organization].[EmployerContacts].lastName) as name
,	[organization].[EmployerContacts].phone as phone
,	[organization].[EmployerContacts].email as email
FROM [organization].[EmployerContacts]
Where [organization].[EmployerContacts].id = @ContactID
