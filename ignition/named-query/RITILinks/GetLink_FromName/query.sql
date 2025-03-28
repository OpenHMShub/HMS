SELECT 
	[id]
	,[name]
	,[url]
	,[timeCreated]
FROM 
	[dbo].[RITILinks]
WHERE
	[name] like :linkName