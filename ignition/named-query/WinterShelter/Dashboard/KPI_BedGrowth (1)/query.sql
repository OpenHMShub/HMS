Declare @test int = 96;

SELECT 
	cast(@test & 1 as bit) as 'monday',
	cast(@test & 2 as bit) as 'tuesday',
	cast(@test & 4 as bit) as 'wednesday',
	cast(@test & 8 as bit) as 'thursday',
	cast(@test & 16 as bit) as 'friday',
	cast(@test & 32 as bit) as 'saturday',
	cast(@test & 64 as bit) as 'sunday'
	
FROM shelter.LocationSeasonal ls
where ls.locationId = 160