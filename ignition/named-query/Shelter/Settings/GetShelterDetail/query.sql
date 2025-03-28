SELECT id,  facilityName, facilityDescription, facilityTypeId, street, city, state, zipCode, phone, email, allResidential
FROM lodging.Facility
WHERE id = :facilityId and timeRetired IS NULL