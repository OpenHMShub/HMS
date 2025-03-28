SELECT shelter.Location.locationName,
  shelter.Amenity.amenityName,
  shelter.Amenity.amenityDescription
FROM shelter.LocationPreference
  INNER JOIN shelter.LocationAmenity
    ON shelter.LocationAmenity.locationPreferenceId =
    shelter.LocationPreference.id
  INNER JOIN shelter.Amenity ON shelter.Amenity.id =
    shelter.LocationAmenity.amenityId
  INNER JOIN shelter.Location ON shelter.LocationPreference.locationId =
    shelter.Location.id