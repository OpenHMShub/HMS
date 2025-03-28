UPDATE lodging.FacilityAssociatedPrograms
SET timeRetired = CURRENT_TIMESTAMP WHERE facilityId = :facilityId

UPDATE lodging.Bed
SET timeRetired = CURRENT_TIMESTAMP
WHERE roomId in ( SELECT id FROM lodging.Room WHERE facilityId = :facilityId )

UPDATE lodging.Room
SET timeRetired = CURRENT_TIMESTAMP WHERE facilityId = :facilityId

UPDATE lodging.Facility
SET timeRetired = CURRENT_TIMESTAMP WHERE id = :facilityId

