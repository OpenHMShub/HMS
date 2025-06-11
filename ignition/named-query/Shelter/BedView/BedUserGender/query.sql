SELECT left(isnull(gender,'O'),1) as valReturned
FROM [humans].[Human]
INNER JOIN [participant].[Participant] ON [humans].[Human].[id] = [participant].[Participant].[humanId] 
WHERE [participant].[Participant].[id] =  :UserID