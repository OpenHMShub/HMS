DECLARE 
@business_description AS nvarchar(200) = :business_description
,@status AS nvarchar(200) = :status
,@city AS nvarchar(200) = :city
,@action_start AS DATE = :action_start
,@action_end AS DATE = :action_end
,@qualifier1 AS nvarchar(200) = :qualifier1
,@qualifier2 AS nvarchar(200) = :qualifier2
,@qualifier3 AS nvarchar(200) = :qualifier3
,@qualifier4 AS nvarchar(200) = :qualifier4
,@qualifier5 AS nvarchar(200) = :qualifier5
,@qualifier6 AS nvarchar(200) = :qualifier6


SELECT m.* FROM 
--joining table to itself to eliminate duplicate employers; this select is the same as the chunk below being aliased as b. you can't nest AS statements, hence the copy pasta
(SELECT 
[organization].[EmployerNew].[id] as 'ID'
,[organization].[EmployerNew].[Employer Name]
,[organization].[EmployerNew].[Business Description]
,[organization].[EmployerNew].[Status]
,[organization].[EmployerNew].[phone] as 'Phone'
,[organization].[EmployerNew].[street] as 'Address'
,[organization].[EmployerNew].[city] as 'City'
,[organization].[EmployerNew].[zipCode] as 'Zip Code'
,[organization].[EmployerNew].[website] as 'Website'
,[organization].[EmployerNew].[Qualifiers]
,(SELECT MAX(maxSingleEntry)
FROM ( VALUES ([organization].[ApplicantStatus].[appliedDate]), ([organization].[ApplicantStatus].[interviewedDate]), ([organization].[ApplicantStatus].[hiredDate])) AS VALUE(maxSingleEntry))
As 'Last Action'

FROM [organization].[EmployerNew]

LEFT JOIN [organization].[ApplicantStatus]
	ON [organization].[EmployerNew].[id] = [organization].[ApplicantStatus].[employerId]
) as m

LEFT JOIN 
--same chunk as above, produces table with duplicates
(SELECT 
[organization].[EmployerNew].[id] as 'ID'
,[organization].[EmployerNew].[Employer Name]
,[organization].[EmployerNew].[Business Description]
,[organization].[EmployerNew].[Status]
,[organization].[EmployerNew].[phone] as 'Phone'
,[organization].[EmployerNew].[street] as 'Address'
,[organization].[EmployerNew].[city] as 'City'
,[organization].[EmployerNew].[zipCode] as 'Zip Code'
,[organization].[EmployerNew].[website] as 'Website'
,[organization].[EmployerNew].[Qualifiers]
,(SELECT MAX(maxSingleEntry)
FROM ( VALUES ([organization].[ApplicantStatus].[appliedDate]), ([organization].[ApplicantStatus].[interviewedDate]), ([organization].[ApplicantStatus].[hiredDate])) AS VALUE(maxSingleEntry))
As 'Last Action'

FROM [organization].[EmployerNew]

LEFT JOIN [organization].[ApplicantStatus]
	ON [organization].[EmployerNew].[id] = [organization].[ApplicantStatus].[employerId]
) as b
	
ON m.ID = b.ID
AND m.[Last Action] < b.[Last Action]
WHERE b.[Last Action] IS NULL
	AND ((m.[Business Description] like '%' + IsNull(@business_description,m.[Business Description]) + '%') OR (m.[Business Description] IS NULL AND @business_description IS NULL))
	AND ((m.[Status] like '%' + IsNull(@status,m.[Status]) + '%') OR (m.[Status] IS NULL AND @status IS NULL))
	AND ((m.[City] like '%' + IsNull(@city,m.[City]) + '%') OR (m.[City] IS NULL AND @city IS NULL))
	AND ((m.[Qualifiers] like '%' + IsNull(@qualifier1,m.[Qualifiers]) + '%') OR (m.[Qualifiers] IS NULL AND @qualifier1 IS NULL))
	AND ((m.[Qualifiers] like '%' + IsNull(@qualifier2,m.[Qualifiers]) + '%') OR (m.[Qualifiers] IS NULL AND @qualifier2 IS NULL))
	AND ((m.[Qualifiers] like '%' + IsNull(@qualifier3,m.[Qualifiers]) + '%') OR (m.[Qualifiers] IS NULL AND @qualifier3 IS NULL))
	AND ((m.[Qualifiers] like '%' + IsNull(@qualifier4,m.[Qualifiers]) + '%') OR (m.[Qualifiers] IS NULL AND @qualifier4 IS NULL))
	AND ((m.[Qualifiers] like '%' + IsNull(@qualifier5,m.[Qualifiers]) + '%') OR (m.[Qualifiers] IS NULL AND @qualifier5 IS NULL))
	AND ((m.[Qualifiers] like '%' + IsNull(@qualifier6,m.[Qualifiers]) + '%') OR (m.[Qualifiers] IS NULL AND @qualifier6 IS NULL))
  	AND (
  	(((m.[Last Action] IS NULL) OR (m.[Last Action] IS NOT NULL)) AND (@action_start IS NULL OR @action_end IS NULL))
  	OR 
  	((m.[Last Action] between @action_start and @action_end) AND (@action_start IS NOT NULL) AND (@action_end IS NOT NULL))
  	)