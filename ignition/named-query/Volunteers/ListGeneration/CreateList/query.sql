INSERT INTO HMSOps.staff.VolunteerListFilter
(username, [filter], timeCreated, filterName)
VALUES(:username, :filter, GETDATE(), :filterName);
