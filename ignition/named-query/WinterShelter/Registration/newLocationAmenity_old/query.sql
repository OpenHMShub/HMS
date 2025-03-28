INSERT INTO shelter.LocationAmenity(
	amenityId,
	locationPreferenceId,
	timeCreated)
VALUES (
	:amenityId,
	:locationPreferenceId,
	GetDate());