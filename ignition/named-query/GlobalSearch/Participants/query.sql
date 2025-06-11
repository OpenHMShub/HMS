/*GlobalSearch/Participants*/
SELECT [ID] as 'ID'
      ,[Suspension] as 'Suspension'
      ,[FirstName] + ' ' + ISNULL([MiddleName],'') + ' ' + [LastName] AS 'Name'
      ,[FirstName] as 'firstName'
      ,[MiddleName] as 'middleName'
      ,[LastName] as 'lastName'
      ,[BirthDate] as 'BirthDate'
      ,[Gender] as 'Gender'
      ,[Race] as 'Race'
      ,[veteran] as 'Veteran'
      ,[LastRegistration] as 'LastRegistration'
      ,[LastAction] as 'LastAction'
      ,[Shelter] as 'Shelter'
      ,[reservation] as 'Reservation'
  FROM [participant].[Dashboard]
 
