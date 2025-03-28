SELECT [ID]
      ,[Suspension]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[NickName]
      ,FORMAT([BirthDate], 'd', 'us') AS 'BirthDate'
      , CAST((DATEDIFF(day, [BirthDate], GetDate()))/365.25 as INT) as 'Age'
      ,[GenderId]
      ,[Gender]
      ,[RaceId]
      ,[Race]
      ,[VeteranId]
      ,[veteran]
      ,FORMAT([LastRegistration], 'd', 'us') AS 'LastRegistration'
      ,FORMAT([LastAction], 'd', 'us') AS 'LastAction'
      ,[Shelter]
      ,[reservation] 
  FROM [participant].[Dashboard]
  WHERE
 	{activity_range} AND
 	{gender} AND 
 	{race} AND
 	{veteran} AND
 	{firstname} AND
 	{middlename} AND
 	{lastname} AND
 	{nickname} AND
 	{birthdate} AND  
 	{age} AND 
 	{birthdate} AND 
 	{shelter} AND 
 	{registration}
 	
  ORDER BY LastAction DESC;