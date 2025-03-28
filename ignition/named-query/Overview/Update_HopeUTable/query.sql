SET NOCOUNT ON
DECLARE 
	@dateToday date,
	@ShowerCount int,
	@LaundryCount int,
	@MailCheckRitiCount int,
	@NumberOfClasses int,
	@ClassAttendance int,
	@InPersonStore int,
	@NavigationService int,
	@FootClinic int,
	@phoneAccess int
	

SET @dateToday = :dateToday
SELECT @ShowerCount = count(participantId) FROM participant.ServicesDashboard WHERE CAST(serviceDate AS DATE) = CAST(@dateToday AS DATE) AND serviceName like '%shower%'
SELECT @LaundryCount = count(participantId) FROM participant.ServicesDashboard WHERE CAST(serviceDate AS DATE) = CAST(@dateToday AS DATE) AND serviceName like '%laundry%'
SELECT @MailCheckRitiCount = count(participantId) FROM participant.ServicesDashboard WHERE CAST(serviceDate AS DATE) = CAST(@dateToday AS DATE) AND serviceName like '%Mail Pick Up%'
SELECT @NumberOfClasses = count(distinct name) + (select count(id) from [participant].[Events] where CAST([startsOn] AS DATE) = CAST(@dateToday AS DATE))
						FROM [calendar].[EventAttendance] 
						INNER JOIN [calendar].[CalendarEvents] on [EventAttendance].[eventId] = [CalendarEvents].[id]
						INNER JOIN [humans].[Human] ON [Human].[id] = [EventAttendance].[humanId]
						INNER JOIN [participant].[Participant] ON [Participant].[humanId] = [Human].[id]
						WHERE [CalendarEvents].calendarId = 2 and CAST([EventAttendance].[checkin] AS DATE) = CAST(@dateToday AS DATE)
						
						
SELECT @ClassAttendance = count([Participant].[id]) + (select count(id) from [participant].[EventAttendance] where CAST([checkin] AS DATE) = CAST(@dateToday AS DATE))
						FROM [calendar].[EventAttendance] 
						INNER JOIN [calendar].[CalendarEvents] on [EventAttendance].[eventId] = [CalendarEvents].[id]
						INNER JOIN [humans].[Human] ON [Human].[id] = [EventAttendance].[humanId]
						INNER JOIN [participant].[Participant] ON [Participant].[humanId] = [Human].[id]
						WHERE [CalendarEvents].calendarId = 2 and CAST([EventAttendance].[checkin] AS DATE) = CAST(@dateToday AS DATE)
						
						
SELECT @InPersonStore = count(participantId) FROM participant.ServicesDashboard WHERE CAST(serviceDate AS DATE) = CAST(@dateToday AS DATE) AND serviceName like '%In-Person Store%'
SET @InPersonStore =  @InPersonStore + (select count(participantId) FROM participant.CampusStore where CAST(timeCreated AS DATE) = CAST(@dateToday AS DATE) AND Category = (select id from participant.CampusStoreCategory where name like '%What''s Inn Store Voucher Purchase%'))
						
SET @phoneAccess = (SELECT [navigationPhoneAccess] FROM [participant].[HopeUDashboard] where CAST([date] as date) = CAST(@dateToday AS DATE))
SET @NavigationService = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE CAST(serviceDate AS DATE) = CAST(@dateToday AS DATE) AND (serviceName like '%Computer%' or serviceName like '%Assist With Obtaining ID Card%' or serviceName like '%Social Security RITI Shuttle%' or serviceName like '%Assist With Obtaining Birth Certificate%' or serviceName like '%Homeless Letter Provided%' or serviceName like '%DHS Entitlement Navigation%' or serviceName like '%Connected with MHC Outreach%')) + ISNULL(@phoneAccess,0)
-- SET @FootClinic = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE CAST(serviceDate AS DATE) = CAST(@dateToday AS DATE) AND serviceName like '%Foot Clinic%')
SET @FootClinic = (SELECT count(participantId) from participant.EventAttendance where CAST(checkin AS DATE) = CAST(@dateToday AS DATE) and scheduleId in ( SELECT s.id FROM participant.Events e , participant.eventSchedule s where s.eventId = e.id and e.name = 'Foot Clinic' and e.timeRetired is NULL and s.timeRetired IS NULL))

-- update [participant].[HopeUDashboard] table
UPDATE 
	[participant].[HopeUDashboard]
SET
	[showers] = @ShowerCount,
	[laundry] = @LaundryCount,
	[mailCheckRITI] = @MailCheckRitiCount,
	[noOfClasses] = @NumberOfClasses,
	[classAttendance] = @ClassAttendance,
	[inPersonStore] = @InPersonStore,
	[navigationService] = @NavigationService,
	[footClinic] =  @FootClinic
WHERE
	CAST([date] AS DATE) = CAST(@dateToday AS DATE)