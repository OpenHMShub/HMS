/*Participants/Dashboard/ParticipantsDashboardSelect*/
DECLARE @activity_range AS INT = :activity_range
		,@genderIdAll AS nvarchar(max)
		,@genderId AS nvarchar(max) = :gender_id
		,@raceIdAll AS nvarchar(max)
		,@raceId AS nvarchar(max) = :race_id
		,@veteranIdAll AS nvarchar(max)
		,@veteranId AS nvarchar(max) = :veteran_id;
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());
--Get the default values for gender, race, and veteran status
SET @genderIdAll = (SELECT STRING_AGG(id,',') AS csv FROM humans.Gender);
SET @raceIdAll = (SELECT STRING_AGG(id,',') AS csv FROM humans.Race);
SET @veteranIdAll = (SELECT STRING_AGG(id,',') AS csv FROM humans.VeteranStatus);

SELECT [ID]
      ,[Suspension]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[NickName]
      ,[BirthDate]
      , CAST((DATEDIFF(day, [BirthDate], GetDate()))/365.25 as INT) as 'Age'
      ,[GenderId]
      ,[Gender]
      ,[RaceId]
      ,[Race]
      ,[VeteranId]
      ,[veteran]
      ,[LastRegistration]
      ,[LastAction]
      ,[Shelter]
      ,[reservation] 
  FROM [participant].[Dashboard]
  WHERE
 	[LastAction] between @activity_start and @activity_end 
 	AND
 	[GenderId] in (SELECT convert(int, value) FROM string_split(IsNull(@genderId,@genderIdAll), ','))
 	AND
 	[RaceId] in (SELECT convert(int, value) FROM string_split(IsNull(@raceId,@raceIdAll), ','))
 	AND
 	[VeteranId] in (SELECT convert(int, value) FROM string_split(IsNull(@veteranId,@veteranIdAll), ','))
  ORDER BY LastAction DESC;