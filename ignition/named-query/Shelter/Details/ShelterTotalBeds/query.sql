SELECT a.beds as beds
FROM lodging.Facility a
where a.timeRetired is null and a.id = :shelterID
   