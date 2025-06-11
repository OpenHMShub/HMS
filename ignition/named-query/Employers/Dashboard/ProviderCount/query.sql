SELECT 
	[organization].[EmployerNew].id
FROM 
	[organization].[EmployerNew]
WHERE 
	[organization].[EmployerNew].id IN (SELECT convert(int, value) FROM string_split(:IdList, ','))