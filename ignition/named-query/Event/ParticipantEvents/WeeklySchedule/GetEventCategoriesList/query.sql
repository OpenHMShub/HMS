SELECT e.name as eventName, c.name as categoryName
FROM participant.Events e, participant.EventCategories c
where e.categoryId = c.id
order by e.name