SELECT id, filterName, [filter]
FROM HMSOps.staff.VolunteerListFilter
WHERE username = :username;
