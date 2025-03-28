/*Providers/Dashboard/ProvidersDashboardSelect*/
DECLARE @provider_name AS nvarchar(max) = :name
 	,@provider_type AS nvarchar(max) =  :type 
	,@last_service AS DATE = :last_service
	,@phone AS nvarchar(max) = :phone 
	,@address AS nvarchar(max) = :address
	,@city AS nvarchar(max) = :city
	,@zip AS INT = :zip
	,@website AS nvarchar(max) = :website; 
SELECT 
	   [organization].[Provider].id
	  ,[organization].[Provider].organizationID		
      ,[organization].[Provider].providerName
      ,[organization].[Provider].nationalProviderIdentifier
      ,[organization].[Provider].regionServed
      ,[organization].[Provider].street
      ,[organization].[Provider].city
      ,[organization].[Provider].state
      ,[organization].[Provider].zipCode
      ,[organization].[Provider].website
      ,[organization].[Provider].phone
      ,[organization].[Provider].email
      ,[organization].[Provider].timeCreated
      ,[organization].[Provider].providerTypeId
      ,[organization].[ProviderType].providerTypeName
  FROM [organization].[Provider]
INNER JOIN
	[organization].[ProviderType]
ON
	[organization].[Provider].providerTypeId=[organization].[ProviderType].id
WHERE providerTypeId is NOT NULL
	AND (ISNULL(providerTypeName,'')) NOT LIKE '%Congregation%'
	AND (ISNULL(providerTypeName,'')) NOT LIKE '%Presenter%'
/*	AND (ISNULL(nationalProviderIdentifier,'')) NOT LIKE ''
	AND (ISNULL(providerName,'')) NOT LIKE '%Congregation%'
	AND (ISNULL(providerName,'')) NOT LIKE '%Presenter%' */