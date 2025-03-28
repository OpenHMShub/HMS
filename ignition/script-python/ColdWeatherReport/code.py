def insertData_forNextMonth(dateToday):
	currentMonth = system.date.getMonth(dateToday)
	firstDateofNextMonth = system.date.getDate(system.date.getYear(dateToday), system.date.getMonth(dateToday)+1, 1)
	lastDateOfCurrentMonth = system.date.addDays(firstDateofNextMonth, -1)
	daysInMonth = system.date.getDayOfMonth(system.date.addDays(system.date.getDate(system.date.getYear(dateToday), system.date.getMonth(dateToday)+2, 1),-1))
	
	ghBedsSettingValue = 0
	## get GH Beds settings data
	selectQ = "SELECT settingValue FROM shelter.ColdWeatherReportSettings WHERE settingName = 'GH Beds'"
	settingsData = system.db.runQuery(selectQ)
	if settingsData is not None and settingsData.getRowCount() > 0:
		settingValue = settingsData.getValueAt(0,0)
		if settingValue is not None:
			ghBedsSettingValue = int(settingValue)
	
	
	
	InsertQuery = """
	INSERT INTO [shelter].[ColdWeatherReportData] 
			   ([month]
	           ,[year]
	           ,[monthDate]
	           ,[dayOfWeek]
	           ,[ghBeds]
	           ,[ghUtilization]
	           ,[congregationalBeds]
	           ,[congregationalBedsUtilization]
	           ,[totalBedsCapacityRITI]
	           ,[totalBedsUtilizedRITI]
	           ,[addedBeds]
	           ,[unUtilizedBeds]
	           ,[notes]
	          ) VALUES 
	"""
	
#	system.perspective.print('HopeU_monthAdd_function')
#	system.perspective.print(dateToday)
#	system.perspective.print(lastDateOfCurrentMonth)
#	if dateToday == lastDateOfCurrentMonth:
	for i in range(0,daysInMonth):
		month = system.date.format(firstDateofNextMonth,'MMMM') #system.date.getMonth(firstDateofNextMonth)
		day = i + 1
		year = system.date.getYear(firstDateofNextMonth)
		monthDate = system.date.getDate(year,system.date.getMonth(firstDateofNextMonth),day)
		monthDateStr = system.date.format(monthDate, 'MM/dd/yyyy')
		weekDayName = system.date.format(monthDate, 'EEEE')
		InsertQuery = InsertQuery + "('"+str(month)+"',"+str(year)+",'"+str(monthDateStr)+"','"+str(weekDayName)+"'," + str(ghBedsSettingValue) + ",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),"
	InsertQuery = InsertQuery[:-1]
#		system.perspective.print(InsertQuery)		
	system.db.runPrepUpdate(InsertQuery)
#	system.perspective.print('Data inserted successfully!')
