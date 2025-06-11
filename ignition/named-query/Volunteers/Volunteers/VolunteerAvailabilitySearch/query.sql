SELECT *
FROM staff.VolunteerAvailability va
WHERE
((va.availabilityType = 1) or 
(va.availabilityType = 2 and :date not between va.startDate and va.endDate) or
(va.availabilityType = 3 and :date between va.startDate and va.endDate))
and CHARINDEX(DATENAME(dw,:date), CASE :mae WHEN 'morning' THEN va.morning WHEN 'afternoon' THEN va.afternoon WHEN 'evening' THEN va.evening ELSE :mae END) > 0;