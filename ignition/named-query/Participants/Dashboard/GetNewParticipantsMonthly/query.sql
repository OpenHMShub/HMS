SELECT YEAR(timeCreated), MONTH(timeCreated), COUNT(id)
FROM participant.participant
WHERE (timeCreated Between DATEADD(month, -6, getDATE()) AND GETDATE())
GROUP BY YEAR(timeCreated), MONTH(timeCreated)
ORDER BY YEAR(timeCreated), MONTH(timeCreated)