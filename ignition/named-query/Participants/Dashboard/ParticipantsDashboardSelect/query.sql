/*Participants/Dashboard/ParticipantsDashboardSelect*/
DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());

SELECT x.*,ISNULL(billingTable.billing,'') as billing  FROM
(
SELECT [ID]
	  ,1 as 'Detail'	
      ,[participant].[Dashboard].[Suspension]
      ,[participant].[Dashboard].[fullRegistration]
      ,CONCAT_WS(' ',[participant].[Dashboard].[FirstName],[participant].[Dashboard].[MiddleName],[participant].[Dashboard].[LastName]) as 'Name'
      ,[participant].[Dashboard].[FirstName]
      ,[participant].[Dashboard].[MiddleName]
      ,[participant].[Dashboard].[LastName]
      ,[participant].[Dashboard].[NickName]
      -- ,DATEADD(hh,12,CAST([participant].[Dashboard].[BirthDate] as DATETIME)) as 'BirthDate'
      ,[participant].[Dashboard].[BirthDate]
      ,[participant].[Dashboard].[Age]
      ,[participant].[Dashboard].[GenderId]
      ,[participant].[Dashboard].[Gender]
      ,[participant].[Dashboard].[RaceId]
      ,[participant].[Dashboard].[Race]
      ,[participant].[Dashboard].[VeteranId]
      ,[participant].[Dashboard].[veteran]
      ,[participant].[Dashboard].[LastRegistration]
      ,[participant].[Dashboard].[LastAction] AS 'LastActivity'
      ,[participant].[Dashboard].[shelterId]
      ,[participant].[Dashboard].[Shelter]
--      ,(SELECT STUFF((SELECT ', ' + CAST(programName AS VARCHAR(10)) [text()] FROM participant.Enrollments e left join interaction.Program i on e.programId = i.id where e.particpantId = [participant].[Dashboard].[ID] FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)'),1,2,' ')) programs  
--      ,(SELECT STUFF((SELECT ', ' + CAST(programName AS VARCHAR(100)) [text()] FROM participant.Enrollments e left join interaction.Program i on e.programId = i.id where e.particpantId = [participant].[Dashboard].[ID] FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)'),1,2,' ')) as programList    
--      ,ISNULL(billingTable.billing,'') as billing 		  	
      ,'' as programs
      /*,[participant].[Dashboard].[reservation]*/
      ,CASE WHEN GETDATE() < [participant].[CurrentReservations].[end_date] THEN 1 ELSE 0 END AS 'reservation'
      ,(SELECT hh.familyId FROM [participant].[Participant] pp, [humans].[Human] hh WHERE pp.id = [participant].[Dashboard].[ID] AND pp.humanId = hh.id) as familyId
      ,(SELECT RIGHT(hh.SSN, 4) FROM [participant].[Participant] pp, [humans].[Human] hh WHERE pp.id = [participant].[Dashboard].[ID] AND pp.humanId = hh.id) as SSN
      --,(SELECT programId FROM participant.Enrollments pe where pe.particpantId = [participant].[Dashboard].[ID]) as programId
FROM [participant].[Dashboard]

LEFT JOIN [participant].[CurrentReservations] ON [participant].[Dashboard].[ID] = [participant].[CurrentReservations].[participant_id]

WHERE
 	--[participant].[Dashboard].[LastAction] between @activity_start and @activity_end AND
 	[participant].[Dashboard].[LastAction] > @activity_start AND
 	{programId} AND
 	{genderid} AND
 	{raceid} AND
 	{veteranid} AND
 	{firstname} AND
 	{middlename} AND
 	{lastname} AND
 	{nickname} AND
 	{dobyear} AND
 	{minage} AND
 	{maxage} AND
 	{shelter} AND
 	{fullRegistration} 
 	--{search}
  ) x
  LEFT JOIN
	(SELECT e.particpantId, STRING_AGG((case when programName = 'ARP' then 'ARP'
      				when programName = 'Veterans Hospital to Housing' then 'GPD H2H'
					when programName = 'Veterans Low Demand' then 'GPD LD'
					when programName = 'Veterans Service Intensive' then 'GPD SI'
					else  '' end),',') as 'billing'
      		FROM participant.Enrollments e
      		left join interaction.Program i on e.programId = i.id 
      		where i.timeRetired is null and i.programName in ('ARP','Veterans Hospital to Housing','Veterans Low Demand','Veterans Service Intensive')
      		Group by e.particpantId
      )billingTable ON x.[ID] = billingTable.particpantId
      
  WHERE  {search} AND
 		{billing}
  ORDER BY x.LastActivity DESC;