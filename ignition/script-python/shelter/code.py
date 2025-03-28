def bedQry (bedId):
	query = """
	DECLARE @OneDay datetime = ?, 
	    @bedId int = ?

	;WITH r AS (
	SELECT [bedId]
	    ,[participantId]
	    ,[reservationStart] as dateStart
	FROM [RitiOps].[lodging].[Reservation]  
	WHERE ([Reservation].[timeRetired] IS NULL
	    AND [Reservation].[reservationStart] IS NOT NULL    
	    AND [Reservation].[reservationStart] <= @OneDay
	    AND ISNULL([Reservation].[reservationEnd],@OneDay) >= @OneDay
	    AND [Reservation].[bedId] = @bedId)
	)
	
	,o AS (
	SELECT [bedId]
	    ,[participantId]
	    ,[eventStart] as dateStart
	FROM [RitiOps].[lodging].[BedLog]  
	WHERE ([eventStart] IS NOT NULL    
	    AND [eventStart] <= @OneDay
	    AND ISNULL([eventEnd],@OneDay) >= @OneDay
	    AND [BedLog].[bedId] = @bedId)
	)
	
	, ro AS (
	 SELECT [bedId], [participantId], 2 AS [bedState], dateStart FROM o
	 UNION ALL 
	 SELECT [bedId], [participantId], 1 AS [bedState], dateStart FROM r
	 )
		
	SELECT ro.[bedId]
	    ,ro.[participantId]
	    ,ro.[bedState]
	    ,ro.[dateStart]
	    ,[Facility].[id] AS facilityId, [Room].[id] AS roomId
	    ,[Facility].[facilityName], [Room].[roomName], [Bed].[bedName]
	    ,ISNULL(TRY_CONVERT(int, SUBSTRING([bedName], PATINDEX('%[0-9]%', [bedName]), LEN([bedName]))),-1) bedNameNo 
	    ,CONCAT_WS(' ',[Human].[firstName],[Human].[middleName],[Human].[lastName]) AS participantName
	FROM ro
	INNER JOIN [RITIOps].[participant].[Participant] ON [Participant].[id] = ro.[participantId] 
	INNER JOIN [RITIOps].[humans].[Human] ON [Participant].[humanId] = [Human].[id] 
	INNER JOIN  [RitiOps].[lodging].[Bed] ON ro.[bedId] = [Bed].[id] 
	INNER JOIN [RitiOps].[lodging].[Room] ON [Bed].[roomId] = [Room].[id]
	INNER JOIN [RitiOps].[lodging].[Facility] ON [Room].[facilityId] = [Facility].[id]
	"""

	dateIn = system.date.now()
	result = system.db.runPrepQuery(query, [dateIn, bedId], 'RITIOps')

	return result
