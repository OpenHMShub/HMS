SELECT * FROM
(
SELECT TOP 1000
	raceName as 'race'
FROM
	humans.Race
	where raceName not in ('Client doesn''t know', 'Client refused', 'Data not collected')
ORDER by raceName ) x
UNION
SELECT 
	raceName as 'race'
FROM
	humans.Race
	where raceName in ('Client doesn''t know', 'Client refused', 'Data not collected')