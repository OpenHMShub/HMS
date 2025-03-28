SELECT
	id as 'id',
	raceName as 'race'
FROM
	humans.Race
	where raceName not in  ('Client doesn''t know', 'Client refused','Data not collected')
UNION
	SELECT 0 as 'id', 'None Reported' as 'race'
	