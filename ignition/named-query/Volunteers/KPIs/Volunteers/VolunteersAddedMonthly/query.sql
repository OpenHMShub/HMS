SELECT count(v.id) volunteers, cast(DATEADD(month, DATEDIFF(month, 0, V.timeCreated), 0) as date) as time
FROM staff.Volunteer V
WHERE V.timeCreated > DATEADD(month, -6, GETDATE())
GROUP BY DATEADD(month, DATEDIFF(month, 0, V.timeCreated), 0)
ORDER BY DATEADD(month, DATEDIFF(month, 0, V.timeCreated), 0)