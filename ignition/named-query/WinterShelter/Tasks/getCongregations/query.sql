SELECT id, locationName FROM shelter.Location
where timeRetired IS NULL
order by locationName