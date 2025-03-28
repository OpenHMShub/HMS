def insertData_forNextMonth(dateToday):
#	dateToday = system.date.now()
#	dateToday = system.date.getDate(2023,1,28) 	# for manually entered date
	currentMonth = system.date.getMonth(dateToday)
	firstDateofNextMonth = system.date.getDate(system.date.getYear(dateToday), system.date.getMonth(dateToday)+1, 1)
	lastDateOfCurrentMonth = system.date.addDays(firstDateofNextMonth, -1)
	daysInMonth = system.date.getDayOfMonth(system.date.addDays(system.date.getDate(system.date.getYear(dateToday), system.date.getMonth(dateToday)+2, 1),-1))
#	InsertQuery = 'INSERT INTO [participant].[HopeUDashboard] Values '
	InsertQuery = 'INSERT INTO [participant].[HopeUDashboard] (month, day, year, isClosed, isWeekend, date) Values '
#	system.perspective.print('HopeU_monthAdd_function')
#	system.perspective.print(dateToday)
#	system.perspective.print(lastDateOfCurrentMonth)
#	if dateToday == lastDateOfCurrentMonth:
	for i in range(0,daysInMonth):
		month = system.date.format(firstDateofNextMonth,'MMMM') #system.date.getMonth(firstDateofNextMonth)
		day = i + 1
		year = system.date.getYear(firstDateofNextMonth)
		dayOfWeek = system.date.getDayOfWeek(system.date.getDate(year,system.date.getMonth(firstDateofNextMonth),day))
		if dayOfWeek == 1 or dayOfWeek == 7:
			IsWeekend = 1
		else:
			IsWeekend = 0 
#		InsertQuery = InsertQuery + "('"+str(month)+"',"+str(day)+','+str(year)+',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'+str(IsWeekend)+',NULL,datefromparts('+str(year)+", MONTH(concat('"+str(month)+"',' ',"+str(day)+",' ',"+str(year)+')), '+str(day)+'),NULL),'
		InsertQuery = InsertQuery + "('"+str(month)+"',"+str(day)+','+str(year)+',0,'+str(IsWeekend)+',datefromparts('+str(year)+", MONTH(concat('"+str(month)+"',' ',"+str(day)+",' ',"+str(year)+')), '+str(day)+')),'
	InsertQuery = InsertQuery[:-1]
#		system.perspective.print(InsertQuery)		
	system.db.runPrepUpdate(InsertQuery)
#	system.perspective.print('Data inserted successfully!')
