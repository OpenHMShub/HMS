SELECT F.id, CONCAT(H.firstName,' ',H.middleName,' ',H.lastName) as "name", H.phone as "phone",  
	(
		select CONCAT(count(A.volunteerId) + count(A.volunteerGroupId), '/', count(J.id))
		from staff.Assignments A
		left join staff.VolunteerJobs J on A.volunteerJobsId = J.id
		where CAST(A.timeStart AS DATE) = CAST(GETDATE() AS DATE)
		group by J.facilitatorId
		having J.facilitatorId = F.id
	) as "converageToday",
	(
		select CONCAT(count(A.volunteerId) + count(A.volunteerGroupId), '/', count(J.id))
		from staff.Assignments A
		left join staff.VolunteerJobs J on A.volunteerJobsId = J.id
		where CAST(A.timeStart AS DATE) = CAST(dateadd(day, 1, GETDATE()) AS DATE)
		group by J.facilitatorId
		having J.facilitatorId = F.id
	) as "converageTomorrow",
	(
		select CONCAT(count(A.volunteerId) + count(A.volunteerGroupId), '/', count(J.id))
		from staff.Assignments A
		left join staff.VolunteerJobs J on A.volunteerJobsId = J.id
		where CAST(A.timeStart AS DATE) >= CAST(GETDATE() AS DATE) and CAST(A.timeStart AS DATE) < CAST(dateadd(day, 7, GETDATE()) AS DATE)
		group by J.facilitatorId
		having J.facilitatorId = F.id
	) as "converageSevenDay",
	(
		SELECT TOP 1 CONCAT(C.title,' - ', I.venue, ' - ',I.room) 
		from calendar.eventInstanceFacilitators EIF
		left join calendar.eventInstances I on I.instanceID = EIF.instanceID
		left join calendar.CalendarEvents C on C.eventID = I.parentEventID
		WHERE EIF.facilitatorID = F.id and I.startDate > GETDATE() ORDER BY I.startDate ASC
	) as "nextEvent", 
	(
		SELECT TOP 1 
		cast(E.startDate as date)
		from calendar.eventInstanceFacilitators EIF 
		left join calendar.eventInstances E on E.instanceID = EIF.instanceID
		WHERE EIF.facilitatorID = f.id and E.startDate > GETDATE() ORDER BY E.startDate ASC
	) as "nextEventDate",
	(
		SELECT TOP 1 CONCAT(C.title,' - ', I.venue, ' - ',I.room) 
		from calendar.eventInstanceFacilitators EIF
		left join calendar.eventInstances I on I.instanceID = EIF.instanceID
		left join calendar.CalendarEvents C on C.eventID = I.parentEventID
		WHERE EIF.facilitatorID = F.id and I.startDate < GETDATE() ORDER BY I.startDate DESC
	) as "lastEvent", 
	(
		SELECT TOP 1 
		cast(E.startDate as date)
		from calendar.eventInstanceFacilitators EIF 
		left join calendar.eventInstances E on E.instanceID = EIF.instanceID
		WHERE EIF.facilitatorID = f.id and E.startDate < GETDATE() ORDER BY E.startDate DESC
	) as "lastEventDate"
FROM staff.Facilitator F
Inner join staff.Employee E on F.employeeId = E.id
Inner join humans.Human H on E.humanId = H.id
group by H.firstName, H.middleName, H.lastName, H.phone, F.id, F.timeRetired
HAVING F.timeRetired is null;