
DECLARE @employerId int = :trackID
;WITH cte AS (
SELECT
	 [EmployerNew].[id] AS [employerId]
	,STRING_AGG([Qualifier].[Qualifier_Description],',') AS [Qualifiers]
FROM [organization].[EmployerNew]
LEFT JOIN [organization].[EmployerNewQualifier] ON [EmployerNewQualifier].[EmployerNewId] = [EmployerNew].[id]
LEFT JOIN [organization].[Qualifier] ON [Qualifier].[ID] = [EmployerNewQualifier].[QualifierId]
WHERE [EmployerNew].[id] = @employerId
GROUP BY [EmployerNew].[id]
)

SELECT 
	 [EmployerNew].[Employer Name] as [EmployerName]
	,[BusinessDescription].[BusinessDescription] AS 'BusinessDescription'
	,CASE WHEN [EmployerNew].[timeRetired] IS NULL THEN 'ACTIVE' ELSE 'NOT ACTIVE' END AS [Status]
	,[EmployerNew].[timeCreated] As 'EmployerDateTime' /*placeholder*/
	,[EmployerNew].[phone] as 'Phone'
	,[EmployerNew].[street]+', '+[city]+', '+CONVERT(varchar,[zipCode]) as 'Address'
	,[EmployerNew].[website] as 'Website'
	,cte.[Qualifiers]
FROM cte
	LEFT JOIN [organization].[EmployerNew] ON [EmployerNew].[id] = cte.[employerId]
	LEFT JOIN [organization].[BusinessDescription] ON [BusinessDescription].[BusinessDescriptionID] = [EmployerNew].[BusinessDescriptionID]
