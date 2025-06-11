--DECLARE outputTBL TABLE (eventID int)

INSERT INTO calendar.CalendarEvents 
(allDay, audienceMen, audienceMinors, audienceParticipants, audienceStaff, audienceVolunteers, audienceWomen, bymonth,
bysetpos, category, description, endDate, freq, friday, interval, monday, room, saturday, staffNeeded, startDate, subCategory,
sunday, thursday, title, tuesday, venue, volunteersNeeded, wednesday, deleted, repeat)

OUTPUT INSERTED.eventID --INTO outputTBL(eventID)

VALUES 
(:allDay, :audienceMen, :audienceMinors, :audienceParticipants, :audienceStaff, :audienceVolunteers, :audienceWomen, :bymonth,
:bysetpos, :category, :description, :endDate, :freq, :friday, :interval, :monday, :room, :saturday, :staffNeeded, :startDate,
:subCategory, :sunday, :thursday, :title, :tuesday, :venue, :volunteersNeeded, :wednesday, 0, 0)

--SELECT eventID from outputTBL