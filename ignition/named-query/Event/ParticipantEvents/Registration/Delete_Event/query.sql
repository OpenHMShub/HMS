-- first delete from EventAttendance table
DELETE FROM [participant].[EventAttendance] where [scheduleId] in (select id from [participant].[EventSchedule] where [eventId] = :eventId)

-- Delete from table
DELETE FROM [participant].[EventSheduleSelectedFacilitators] where [scheduleId] in (select id from [participant].[EventSchedule] where [eventId] = :eventId)

-- Delete from table
DELETE FROM [participant].[EventSchedule] where eventId = :eventId

-- Delete from table
DELETE FROM [participant].[EventSelectedFacilitators] where eventId = :eventId

-- Delete from table
DELETE FROM [participant].[EventNotes] where eventId = :eventId

-- Delete from table
DELETE FROM [participant].[Events] where id = :eventId
