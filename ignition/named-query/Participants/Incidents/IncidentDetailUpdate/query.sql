DECLARE @currDate DATETIME;
SET @currDate = GETDATE();

UPDATE participant.IncidentLog

SET	barParticipant = :bar_participant,
	employeeId = :employee_id,
 	incidentDate = :incident_date,
  	incidentDescription = :incident_description,
   	incidentLocationTypeID = :incident_location, 
    incidentName = :incident_name,
    physicalInjury = :physical_injury, 
    propertyDamage = :property_damage, 
    timeCreated = @currDate,
    ParticipantID  = :participant_id 

WHERE id = :row_id;
