/*Participants/Dashboard/ParticipantsDashboardSelect*/
DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());

SELECT * FROM
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
      /*,[participant].[Dashboard].[reservation]*/
      ,CASE WHEN GETDATE() < [participant].[CurrentReservations].[end_date] THEN 1 ELSE 0 END AS 'reservation'
      ,(SELECT hh.familyId FROM [participant].[Participant] pp, [humans].[Human] hh WHERE pp.id = [participant].[Dashboard].[ID] AND pp.humanId = hh.id) as familyId
FROM [participant].[Dashboard]

LEFT JOIN [participant].[CurrentReservations] ON [participant].[Dashboard].[ID] = [participant].[CurrentReservations].[participant_id]

WHERE
 	[participant].[Dashboard].[LastAction] between @activity_start and @activity_end AND
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
 	{fullRegistration} AND
 	{search}
  ) x
  WHERE {familyId}  
  ORDER BY x.LastActivity DESC;