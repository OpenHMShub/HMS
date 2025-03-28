INSERT INTO lodging.Facility(facilityName, timeCreated, allResidential, beds, city,email, facilityDescription, facilityTypeId, phone, rooms, state, street, zipCode) 
VALUES (:facilityName, CURRENT_TIMESTAMP, 0, 0,'','','',0,'',0,'','',0)

SELECT TOP 1 id FROM
lodging.facility
WHERE facilityName = :facilityName
ORDER BY id desc 