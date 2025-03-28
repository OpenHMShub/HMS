INSERT INTO shelter.LocationSeasonal (
	locationId,
	seasonId,
	genderId,
	beds, 
	timeCreated)
VALUES (
	:locationId,
	:seasonId,
	1,
	8,
	getDate());