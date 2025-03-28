/* WinterShelter/Dashboard/DashboardFilter */

DECLARE @dob_start AS DATE = :dob_start
 	,@dob_end AS DATE =  :dob_end 
	,@gender AS INT = :gender
	,@first_name AS nvarchar(max) = :first_name 
	,@last_name AS nvarchar(max) = :last_name
	,@race AS INT = :race
	,@veteran AS INT = :veteran
	,@activity_start AS DATE = :activity_start
	,@activity_end AS DATE = :activity_end
	,@shelter AS nvarchar(max) = :shelter; 
SELECT TOP (100) [ID]
      ,[Suspension]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[BirthDate]
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
  	[FirstName] like IsNull(@first_name,[FirstName]) + '%'
  	AND [LastName] like IsNull(@last_name,[LastName]) + '%'
  	AND [BirthDate] between @dob_start and @dob_end 
  	AND [GenderId] = IsNull(@gender,[genderId])
  	AND [RaceId] = IsNull(@race,[RaceId])
  	AND [VeteranId] = IsNull(@veteran,[veteranId])
  	AND [LastAction] between @activity_start and @activity_end 
  ORDER BY LastAction DESC;