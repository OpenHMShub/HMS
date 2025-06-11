UPDATE calendar.CalendarEvents 
SET
allDay = :allDay, audienceMen = :audienceMen, audienceMinors = :audienceMinors, audienceParticipants = :audienceParticipants,
audienceStaff = :audienceStaff, audienceVolunteers = :audienceVolunteers, audienceWomen = :audienceWomen, bymonth = :bymonth,
bysetpos = :bysetpos, category = :category, description = :description, endDate = :endDate, freq = :freq, friday = :friday,
interval = :interval, monday = :monday, room = :room, saturday = :saturday, staffNeeded = :staffNeeded, startDate = :startDate,
subCategory = :subCategory, sunday = :sunday, thursday = :thursday, title = :title, tuesday = :tuesday, venue = :venue,
volunteersNeeded = :volunteersNeeded, wednesday = :wednesday

WHERE eventID = :eventID