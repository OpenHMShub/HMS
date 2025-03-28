/*---Employers/Activities/SelectSingleContact---*/
Declare @ContactID as int = :contactID  ;

SELECT
	CONCAT([organization].[VendorContacts].firstName
,	' '
,	[organization].[VendorContacts].lastName) as name
,	[organization].[VendorContacts].phone as phone
,	[organization].[VendorContacts].email as email
FROM [organization].[VendorContacts]
Where [organization].[VendorContacts].id = @ContactID
