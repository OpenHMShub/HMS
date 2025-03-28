-- First delete record from attendance table for that scheduleId
DELETE FROM 
	participant.EventAttendance 
WHERE 
	scheduleId in (select id from participant.EventSchedule where eventId = :eventId AND startsOn = :startsOn AND endsOn = :endsOn)


-- Then delete record from EventSelectedFacilitator table for that scheduleId
DELETE FROM 
	participant.EventSheduleSelectedFacilitators 
WHERE 
	scheduleId in (select id from participant.EventSchedule where eventId = :eventId AND startsOn = :startsOn AND endsOn = :endsOn)


-- Finally delete record from EventSchedule table
DELETE FROM [participant].[EventSchedule]
WHERE 
	eventId = :eventId
	AND startsOn = :startsOn
	AND endsOn = :endsOn

