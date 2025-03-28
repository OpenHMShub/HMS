SELECT 
	count(id) 
FROM 
	[shelter].[Tasks] 
WHERE 
	statusId in (1,2) 
	and timeRetired IS NULL 
	and staffId = :loggedInUserId