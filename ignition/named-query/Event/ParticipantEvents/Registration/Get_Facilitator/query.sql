SELECT f.humanId as id, f.name FROM(
SELECT 
	s.humanId, 
	concat(h.firstName,
		CASE when (h.middleName IS NULL or h.middleName='') then '' else ' ' end,
		h.middleName,
		CASE when (h.lastName IS NULL or h.lastName='') then '' else ' ' end,
		h.lastName
	) as name
FROM 
	staff.Employee s
LEFT JOIN
	humans.Human h ON s.humanId = h.id
--WHERE 
--	s.isFacilitator = 1
UNION
SELECT 
	v.humanId, 
	concat(h.firstName,
		CASE when (h.middleName IS NULL or h.middleName='') then '' else ' ' end,
		h.middleName,
		CASE when (h.lastName IS NULL or h.lastName='') then '' else ' ' end,
		h.lastName
	) as name
FROM 
	[staff].[Volunteer] v
LEFT JOIN
	humans.Human h ON v.humanId = h.id
) f
order by f.name asc