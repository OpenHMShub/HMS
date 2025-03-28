UPDATE	participant.services 
SET
	participantId = :participant_id,
	employeeId = :employee_id,
	Serviceid = :service_id ,
	programid = :enrollment_id ,
	userName =  :user_name, 
	HMIS = :HMIS,
	quantity = :quantity,
	comment = :comment,
    timeCreated = :time_created ,
    ServiceLocationId = :service_location_id
WHERE id = :row_id;
