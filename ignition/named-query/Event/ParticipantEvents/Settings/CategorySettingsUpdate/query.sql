UPDATE	participant.EventCategories
SET	name =  :Category_name ,
	color =  :Color,
	isActive = :isActive
WHERE id = :Id ;