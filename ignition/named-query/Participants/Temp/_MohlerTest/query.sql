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
      ,[participant].[CurrentReservations].[end_date]
      ,CASE WHEN GETDATE() < [participant].[CurrentReservations].[end_date] THEN 1 ELSE -1 END AS 'reservation'
       
FROM [participant].[Dashboard]

LEFT JOIN [participant].[CurrentReservations] ON [participant].[Dashboard].[ID] = [participant].[CurrentReservations].[participant_id]

WHERE
 	[participant].[Dashboard].[LastAction] between '2022-01-01' and '2022-06-08'
  
  ORDER BY [participant].[Dashboard].[LastAction] DESC;