INSERT INTO shelter.LocationPreference (
	accessible,
	beds,
	extraShortNotice,
	families,
	genderId,
	locationId,
	nights,
	reminderCall,
	smoking,
	stairs,
	timeCreated)
VALUES (
	:accessible,
	:beds,
	:shortNotice,
	:families,
	:genderId,
	:locationId,
	:nights,
	:reminderCall,
	:smoking,
	:stairs,
	GetDate());
