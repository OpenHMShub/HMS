DECLARE 
	@activity_range AS INT = :activity_range

--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
		,@activity_end AS DATE = DATEADD(day, 1 , getdate());

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

--LEFT JOIN 
--same chunk as above, produces table with duplicates
--(SELECT 
--[organization].[EmployerNew].[id] as 'ID'
--,[organization].[EmployerNew].[Employer Name]
--,[organization].[EmployerNew].[Business Description]
--,[organization].[EmployerNew].[Status]
--,[organization].[EmployerNew].[phone] as 'Phone'
--,[organization].[EmployerNew].[street] as 'Address'
--,[organization].[EmployerNew].[city] as 'City'
--,[organization].[EmployerNew].[zipCode] as 'Zip Code'
--,[organization].[EmployerNew].[website] as 'Website'
--,[organization].[EmployerNew].[Qualifiers]
--,(SELECT MAX(maxSingleEntry)
--FROM ( VALUES ([organization].[ApplicantStatus].[appliedDate]), ([organization].[ApplicantStatus].[interviewedDate]), ([organization].[ApplicantStatus].[hiredDate])) AS VALUE(maxSingleEntry))
--As 'Last Action'
--
--FROM [organization].[EmployerNew]
--
--LEFT JOIN [organization].[ApplicantStatus]
--	ON [organization].[EmployerNew].[id] = [organization].[ApplicantStatus].[employerId]
--) as b
	
--ON m.ID = b.ID
--AND m.[Last Action] < b.[Last Action]
WHERE 
	m.[Last Action] between @activity_start and @activity_end
	--OR m.[Last Action] between @activity_start and @activity_end