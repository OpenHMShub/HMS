import copy

DAYS_OF_THE_WEEK = {
	1: "M",
	2: "T",
	3: "W",
	4: "TH",
	5: "F",
	6: "SAT",
	7: "SUN"
}

DAYS_OF_THE_WEEK_IGN = {
	1: 2,
	2: 3,
	3: 4,
	4: 5,
	5: 6,
	6: 7,
	7: 1
}

def daysToStr(days):
	if not days:
		return ""
	daysStr = ""
	currentDay = 1
	while days > 0:
		if days % 2 != 0:
			daysStr += "%s," % DAYS_OF_THE_WEEK[currentDay]
		currentDay += 1
		days = days >> 1
	return daysStr[:-1]
	
def minutesToTimeStr(minutes):
	if not minutes:
		return ""
	hours, minutes = divmod(minutes, 60)
	if hours >= 12:
		timeStr = "%s:%s PM" % (hours-12, format(minutes, "02"))
	else:
		timeStr = "%s:%s AM" % (hours, format(minutes, "02"))
	return timeStr

def timeStrToMinutes(timeStr):
	pmam = timeStr[-2:]
	hours = int(timeStr.split(":")[0])
	minutes = int(timeStr.split(":")[1][:2].strip())
	hours = 0 if hours == 12 else hours
	if pmam == "PM":
		hours += 12
	return (hours * 60) + minutes
	
def timeStrToMinutesAndHours(timeStr):
	pmam = timeStr[-2:]
	hours = int(timeStr.split(":")[0])
	minutes = int(timeStr.split(":")[1][:2].strip())
	hours = 0 if hours == 12 else hours
	if pmam == "PM":
		hours += 12
	return hours, minutes

def daysDiffIgnList(days, start):
	if not days:
		return []
	daysList = []
	currentDay = 1
	while days > 0:
		if days % 2 != 0:
			day  = DAYS_OF_THE_WEEK_IGN[currentDay]
			diff = day - start if day >= start else (7 - start + day)
			daysList.append(diff)
		currentDay += 1
		days = days >> 1
	return daysList

def createAssignments(activity):
	"""
		activity = {
			name: XXXXX,
			description: XXXXX,
			tasks: [{name: X, description: X}, ....]
			dateEnd: DateTimeObj
			dateStart: DateTimeObj
			times: [{start: '10:00 AM', end: '11:00 AM'}, ....]
			days: 1-127
		}
	"""
	logger = system.util.getLogger("Create Assignments")
	dateStart = system.date.setTime(activity["dateStart"], 0, 0, 0)
	dateEnd = system.date.setTime(activity["dateEnd"], 23, 59, 59)
	startDayOfWeek = system.date.getDayOfWeek(activity["dateStart"])
	daysDiffList = daysDiffIgnList(activity["days"], startDayOfWeek)
	logger.error("Start Date: %s, End Date: %s, DayOfWeek: %s, List: %s" % (dateStart, dateEnd, startDayOfWeek, daysDiffList))
	dates = createStartEndDateTimes(dateStart, dateEnd, daysDiffList, activity['times'])
	logger.error("dates: %s " % dates)
	txId = system.db.beginTransaction(timeout=5000)
	try:
		activityId = addActivity(activity, txId)
		timeIds = addTimes(activityId, activity['times'], txId)
		taskIds = addTasks(activityId, activity["tasks"], txId)
		assignmentIds = addAssignments(activityId, taskIds, dates, txId)
	except:
		logger.error("Error Adding Assignments")
		system.db.rollbackTransaction(txId)
		return False
	system.db.commitTransaction(txId)
	system.db.closeTransaction(txId)
	logger.error("ActivityId: %s TaskIds: %s assignmentIds: %s" % (activityId, taskIds, assignmentIds))
	
def createStartEndDateTimes(dateStart, dateEnd, days, times):
	runningDate = copy.deepcopy(dateStart)
	dates = []
	while runningDate < dateEnd:
		for diff in days:
			newDate = system.date.addDays(runningDate, diff)
			for time in times:
				hour, minutes = timeStrToMinutesAndHours(time["start"])
				length = timeStrToMinutes(time["end"]) - timeStrToMinutes(time["start"])
				newDate = system.date.setTime(newDate, hour, minutes, 0)
				if newDate < dateEnd and newDate >= dateStart:
					start = system.date.addDays(runningDate, diff)
					dates.append({
						'start': newDate,
						'end': system.date.addMinutes(newDate, length)
					})
		runningDate = system.date.addDays(runningDate, 7)
	return dates

def addActivity(activity, txId):
	timeStart = 0
	length = 0
	sqlStr = """INSERT INTO staff.VolunteerJobs 
		(placeId,volunteerJobName,volunteerJobDescription,facilitatorId,timeCreated,dateStart,dateEnd,timeStart,timeLength,days)
		OUTPUT INSERTED.id
		VALUES (?,?,?,?,?,?,?,?,?,?);
	"""
	args = [int(activity['place']),activity['name'],activity['description'],
			activity['facilitator'],system.date.now(),activity['dateStart'],
			activity['dateEnd'],timeStart,length,activity['days']]
	id = system.db.runScalarPrepQuery(sqlStr, args, tx=txId)
	return id
	
def addTimes(jobId, times, txId):
	sqlStr = """INSERT INTO staff.VolunteerJobTimes 
		(volunteerJobsId,timeStart,timeLength)
		OUTPUT INSERTED.id
		VALUES (?,?,?);
	"""
	ids = []
	for time in times:
		start = timeStrToMinutes(time["start"])
		length = timeStrToMinutes(time["end"]) - start
		args = [jobId, start, length]
		id = system.db.runScalarPrepQuery(sqlStr, args, tx=txId)
		ids.append(id)
	return ids
	
def addTasks(activityId, tasks, txId):
	sqlStr = """INSERT INTO staff.VolunteerTask 
		(volunteerJobId,volunteerTaskName,volunteerTaskDescription,timeCreated,gender,ageLow,ageHigh)
		OUTPUT INSERTED.id
		VALUES (?,?,?,?,?,?,?);
	"""
	ids = []
	for task in tasks:
		args = [activityId, task['name'], task['description'], system.date.now(), task['gender'], task['ageMin'], task['ageMax']]
		id = system.db.runScalarPrepQuery(sqlStr, args, tx=txId)
		ids.append(id)
	return ids
	
def addAssignments(jobId, taskIds, startDateTimes, txId):
	sqlStr = """INSERT INTO staff.Assignments 
		(volunteerJobsId,timeStart,timeEnd,timeCreated,volunteerTaskId)
		VALUES (?,?,?,?,?);
	"""
	ids = []
	for time in startDateTimes:
		for taskId in taskIds:
			args = [jobId, time['start'], time['end'], system.date.now(), taskId]
			ids.append(system.db.runPrepUpdate(sqlStr, args, tx=txId, getKey=1))
	return ids
		
	
		
