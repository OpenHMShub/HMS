-- SELECT -2  as id, 'All' as HostLocationType
-- UNION 
SELECT id ,  HostLocationType 
FROM shelter.HostLocationType
WHERE timeRetired IS NULL