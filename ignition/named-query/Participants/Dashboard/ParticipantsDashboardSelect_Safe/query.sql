/*Participants/Dashboard/ParticipantsDashboardSelect*/
DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());

SELECT [ID]
	  ,1 as 'Detail'	
      ,[Suspension]
      ,[fullRegistration]
      ,CONCAT_WS(' ',[FirstName],[MiddleName],[LastName]) as 'Name'
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[NickName]
      ,[BirthDate]
      ,[Age]
      ,[GenderId]
      ,[Gender]
      ,[RaceId]
      ,[Race]
      ,[VeteranId]
      ,[veteran]
      ,[LastRegistration]
      ,[LastAction] AS 'LastActivity'
      ,[shelterId]
      ,[Shelter]
      ,[reservation]
       
FROM [participant].[Dashboard]

WHERE
 	[LastAction] between @activity_start and @activity_end AND
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
  
  ORDER BY [LastAction] DESC;