SELECT * FROM participant.EventCategories
WHERE ( name like '%' + :Category_Name + '%' or  :Category_Name is NULL )
AND ( :activeFilter = 'All' OR
(:activeFilter = 'Active' and isActive = 1) OR
(:activeFilter = 'InActive' and isActive = 0)
)
