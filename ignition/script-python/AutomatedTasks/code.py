def generate_automated_tasks():
	#----------------------------------------------Declaration--------------------------------------
	project = "HMS"
	
	
	#----------------------------------------------Sub Functions--------------------------------------
	def send_email(toAddress,emailText,emailSubject,loggerName):
		to_addr = toAddress
		message = emailText
		logger = system.util.getLogger(loggerName)
	
			
	def prepare_email_text(taskSubject,taskType,participant,taskNotes,assigner,staff,taskPriority,taskDueDate):
		emailText = "<HTML><BODY>"
		emailText = emailText + "Subject : " + str(taskSubject) + "<br>Task Type : " + str(taskType)
		emailText = emailText + "<br>Participant : " + str(participant)
		emailText = emailText + "<br>Notes : " + str(taskNotes) + "<br>Assigner : " + str(assigner)
		emailText = emailText + "<br>Staff : " + str(staff) + "<br>Priority : " + str(taskPriority)
		emailText = emailText + "<br>Due Date : " + str(taskDueDate)
		emailText = emailText + "</BODY></HTML>"
		return emailText
				
	def prepare_email_text_table_row(taskSubject,taskType,participant,taskNotes,assigner,staff,taskPriority,taskDueDate):
		emailText = "<tr>"
		emailText = emailText + "<td style=\"border: 1px solid black; padding: 10px;\">" + str(taskSubject) + "</td>" 
		emailText = emailText + "<td style=\"border: 1px solid black; padding: 10px;\">" + str(taskType) + "</td>" 
		emailText = emailText + "<td style=\"border: 1px solid black; padding: 10px;\">" + str(participant) + "</td>" 
		emailText = emailText + "<td style=\"border: 1px solid black; padding: 10px;\">" + str(taskNotes) + "</td>" 
		emailText = emailText + "<td style=\"border: 1px solid black; padding: 10px;\">" + str(assigner) + "</td>" 
		emailText = emailText + "<td style=\"border: 1px solid black; padding: 10px;\">" + str(staff) + "</td>" 
		emailText = emailText + "<td style=\"border: 1px solid black; padding: 10px;\">" + str(taskPriority) + "</td>" 
		emailText = emailText + "<td style=\"border: 1px solid black; padding: 10px;\">" + str(taskDueDate) + "</td>"
		emailText = emailText + "</tr>"

		return emailText		
	#----------------------------------------------Main Function--------------------------------------
	## get all tasks from database
	staffEmailDict = {}
	taskAll= system.db.runNamedQuery(project=project,path="Settings/Tasks/getAutomatedTasks",parameters={"isActive":-1, "search": "1=1"}, getKey=True)
	if taskAll.getRowCount()>0:
		for i in range(0,taskAll.getRowCount()):
			taskType = taskAll.getValueAt(i,'type')
			automatedTaskId = taskAll.getValueAt(i,'id')
			taskIsActive = taskAll.getValueAt(i,'isActive')
			## create automated tasks and alerts only if task set as active
			if taskIsActive == 1:
				## get all rules for selected task
				taskRules= system.db.runNamedQuery(project=project,path="Settings/Tasks/getAutomatedTaskRules",parameters={"taskId":automatedTaskId}, getKey=True)
				if taskRules.getRowCount()>0:
					for j in range(0,taskRules.getRowCount()):	
						rule = taskRules.getValueAt(j,'entryCriterialLabel')
						entryCriteriaTime = taskRules.getValueAt(j,'entryCriteriaTime')
						entryCriteriaTimeUnits = taskRules.getValueAt(j,'entryCriteriaTimeUnits')
						
						## get time interval for SQL query as per selected unit
						if entryCriteriaTimeUnits == 'hours':
							timeInterval = 'Hour'
						if entryCriteriaTimeUnits == 'weeks':
							timeInterval = 'Week'
						if entryCriteriaTimeUnits == 'days':
							timeInterval = 'Day'
							
						taskDueDateTime = taskRules.getValueAt(j,'taskDueDateTime')
						taskDueDateTimeUnints = taskRules.getValueAt(j,'taskDueDateTimeUnints')
						
						## get task due date as per selected unit and time
						today = system.date.now()
						if taskDueDateTimeUnints == 'hours':
							taskDueDate = system.date.addHours(today, taskDueDateTime)
						if taskDueDateTimeUnints == 'weeks':
							taskDueDate = system.date.addWeeks(today, taskDueDateTime)
						if taskDueDateTimeUnints == 'days':
							taskDueDate = system.date.addDays(today, taskDueDateTime)
						
						## if due date is weekend then set due date as next weekday
						day = system.date.getDayOfWeek(taskDueDate)
						if day == 1: #(1=sunday,7=saturday)
							taskDueDate = system.date.addDays(taskDueDate, 1)
						if day == 7: 
							taskDueDate = system.date.addDays(taskDueDate, 2)
						## set time as 12:30PM similar to task created from UI
						taskDueDate = system.date.setTime(taskDueDate, 12, 30, 00)
						
						taskSubject = taskRules.getValueAt(j,'taskSubject')
						taskTypeId = taskRules.getValueAt(j,'taskType')
						taskType = taskRules.getValueAt(j,'taskTypeName')
						taskNotes = taskRules.getValueAt(j,'taskNotes')
						taskPriorityId = taskRules.getValueAt(j,'taskPriority')
						taskPriority = taskRules.getValueAt(j,'taskPriorityName')
						statusId = 1
						status = "Not Started"
						
						#### Task 1A : When a Participant has been in the Welcome Dorm for 72 hours ####
						if rule == 'Participant has been in the Welcome Dorm':
							
							datefilter = "CAST(bl.eventStart AS DATE) = CAST(dateadd("+str(timeInterval)+", -"+str(entryCriteriaTime)+", CURRENT_TIMESTAMP) AS DATE)"
#							datefilter = "1=1"
							resultRule1A = system.db.runNamedQuery(project=project,path="Settings/Tasks/Task1A_ConfirmIdentity",parameters={"dateRange":datefilter})
#							print(resultRule1A.getRowCount())
							if resultRule1A.getRowCount()>0:
								for k in range(0,resultRule1A.getRowCount()):
									participantId = resultRule1A.getValueAt(k,'participantId')
									participant = resultRule1A.getValueAt(k,'pname')
									staffId = resultRule1A.getValueAt(k,'staffId')
									assignerId = resultRule1A.getValueAt(k,'assignerId')
									staff = resultRule1A.getValueAt(k,'staff')
									assigner = resultRule1A.getValueAt(k,'assigner')
									staffEmail = resultRule1A.getValueAt(k,'staffEmail')
									loggerName = 'Participants in Welcome Dorm'
									logger = system.util.getLogger(loggerName)
									if staffId !=None and staffId != '':
										taskDueDateFormated = system.date.format(taskDueDate,'yyyy-MM-dd HH:mm:ss')
										## send alert email to staff with task detail
										toAddress = staffEmail
										## get formated email text
										emailText = prepare_email_text_table_row(taskSubject,taskType,participant,taskNotes,assigner,staff,taskPriority,taskDueDateFormated)
	#									print(emailText)
										emailSubject = 'Task Created : ' + str(taskSubject)
										message = emailText
										## check if task exist if not then only insert
										checkIfTaskExist = system.db.runNamedQuery("Settings/Tasks/CheckIfTaskExist",parameters={'participantId':participantId,'subject':taskSubject,'staffId':staffId})
										
										if checkIfTaskExist.getRowCount() < 1:
											## changed by YM instead of sending email just add to dict
											#send_email(toAddress,emailText,emailSubject,loggerName)
											emailsList = []
											if toAddress in staffEmailDict:
												emailsList = staffEmailDict[toAddress]
											else:
												emailsList = []
											
											emailsList.append(emailText)
											staffEmailDict[toAddress] = emailsList
											## add task in table
											insertQ = "INSERT INTO participant.Tasks (participantId, taskTypeId, title, dueDate, staffId, assignerId, priority, statusId, notes, timeCreated) VALUES (?,?,?,?,?,?,?,?,?, CURRENT_TIMESTAMP)"
											param = [participantId, taskTypeId, taskSubject, taskDueDateFormated, staffId, assignerId, taskPriorityId, statusId, taskNotes]
											newTaskId = system.db.runPrepUpdate(insertQ, param, getKey = 1)
						
						#### Task 2A : If HMIS update in Registration is blank within 72 hours of Program entry ####
						#### Task 3A : If HMIS update in Registration is blank within 1 week of Program entry ####
						if rule == 'HMIS update in Registration is blank within Program Entry for Non-VA' or rule == 'HMIS update in Registration is blank within Program Entry for VA':
							
							datefilter = "prog.entryDate < dateadd("+str(timeInterval)+", -"+str(entryCriteriaTime)+", CURRENT_TIMESTAMP)"
							if rule == 'HMIS update in Registration is blank within Program Entry for Non-VA':
								isVeteran = "pd.VeteranId != 0"
								loggerName = 'HMIS update blank within Program Entry for Non-VA'
							elif rule == 'HMIS update in Registration is blank within Program Entry for VA':
								isVeteran = "pd.VeteranId = 0"
								loggerName = 'HMIS update blank within Program Entry for VA'
							resultRule2A = system.db.runNamedQuery(project=project,path="Settings/Tasks/Task2A_NonVA_HMISUpdateFor3Days",parameters={"dateRange":datefilter,"isVeteran":isVeteran})
#							print(resultRule2A.getRowCount())
							if resultRule2A.getRowCount()>0:
								
								for k in range(0,resultRule2A.getRowCount()):
									participantId = resultRule2A.getValueAt(k,'participantId')
									participant = resultRule2A.getValueAt(k,'pname')
									staffId = resultRule2A.getValueAt(k,'staffId')
									assignerId = resultRule2A.getValueAt(k,'assignerId')
									staff = resultRule2A.getValueAt(k,'staff')
									assigner = resultRule2A.getValueAt(k,'assigner')
									staffEmail = resultRule2A.getValueAt(k,'staffEmail')
									logger = system.util.getLogger(loggerName)
									if staffId !=None and staffId != '':
										taskDueDateFormated = system.date.format(taskDueDate,'yyyy-MM-dd HH:mm:ss')
										## send alert email to staff with task detail
										toAddress = staffEmail
										## get formated email text
										emailText = prepare_email_text_table_row(taskSubject,taskType,participant,taskNotes,assigner,staff,taskPriority,taskDueDateFormated)
#										print(emailText)
										emailSubject = 'Task Created : ' + str(taskSubject)
										message = emailText
										
										## check if task exist if not then only insert
										checkIfTaskExist = system.db.runNamedQuery("Settings/Tasks/CheckIfTaskExist",parameters={'participantId':participantId,'subject':taskSubject,'staffId':staffId})
										
										if checkIfTaskExist.getRowCount() < 1:
											## changed by YM instead of sending email just add to dict
											#send_email(toAddress,emailText,emailSubject,loggerName)
											emailsList = []
											if toAddress in staffEmailDict:
												emailsList = staffEmailDict[toAddress]
											else:
												emailsList = []
											
											emailsList.append(emailText)
											staffEmailDict[toAddress] = emailsList
											## add task in table
											insertQ = "INSERT INTO participant.Tasks (participantId, taskTypeId, title, dueDate, staffId, assignerId, priority, statusId, notes, timeCreated) VALUES (?,?,?,?,?,?,?,?,?, CURRENT_TIMESTAMP)"
											param = [participantId, taskTypeId, taskSubject, taskDueDateFormated, staffId, assignerId, taskPriorityId, statusId, taskNotes]
											newTaskId = system.db.runPrepUpdate(insertQ, param, getKey = 1)
	#										print(param)	

						#### Task 2B : If a non-VA Participant is in Shelter, and the Last HMIS Update in Registration is equal to 80 days ####
						#### Task 3B : If a VA Participant is in Shelter, and the HMIS update in Registration is equal to 25 days ####
						if rule == 'non-VA Participant is in Shelter, and the Last HMIS Update in Registration is equal to' or rule == 'VA Participant is in Shelter, and the HMIS update in Registration is equal to':
							
							datefilter = "CAST(h.lastHmisUpdateDate AS DATE) = CAST(dateadd("+str(timeInterval)+", -"+str(entryCriteriaTime)+", CURRENT_TIMESTAMP) AS DATE)"
							if rule == 'non-VA Participant is in Shelter, and the Last HMIS Update in Registration is equal to':
								isVeteran = "pd.VeteranId != 0"
								loggerName = 'HMIS not updated for checkin Non-VA participant'
							elif rule == 'VA Participant is in Shelter, and the HMIS update in Registration is equal to':
								isVeteran = "pd.VeteranId = 0"
								loggerName = 'HMIS not updated for checkin VA participant'
							resultRule2B = system.db.runNamedQuery(project=project,path="Settings/Tasks/Task2B_NonVA_HMISUpdateFor80Days",parameters={"dateRange":datefilter,"isVeteran":isVeteran})
#							print(resultRule2B.getRowCount())
							if resultRule2B.getRowCount()>0:
								
								for k in range(0,resultRule2B.getRowCount()):
									participantId = resultRule2B.getValueAt(k,'participantId')
									participant = resultRule2B.getValueAt(k,'pname')
									staffId = resultRule2B.getValueAt(k,'staffId')
									assignerId = resultRule2B.getValueAt(k,'assignerId')
									staff = resultRule2B.getValueAt(k,'staff')
									assigner = resultRule2B.getValueAt(k,'assigner')
									staffEmail = resultRule2B.getValueAt(k,'staffEmail')
									logger = system.util.getLogger(loggerName)
									if staffId !=None and staffId != '':
										taskDueDateFormated = system.date.format(taskDueDate,'yyyy-MM-dd HH:mm:ss')
										## send alert email to staff with task detail
										toAddress = staffEmail
										## get formated email text
										emailText = prepare_email_text_table_row(taskSubject,taskType,participant,taskNotes,assigner,staff,taskPriority,taskDueDateFormated)
#										print(emailText)
										emailSubject = 'Task Created : ' + str(taskSubject)
										message = emailText
									
										## check if task exist if not then only insert
										checkIfTaskExist = system.db.runNamedQuery("Settings/Tasks/CheckIfTaskExist",parameters={'participantId':participantId,'subject':taskSubject,'staffId':staffId})
										if checkIfTaskExist.getRowCount() < 1:
											## changed by YM instead of sending email just add to dict
											#send_email(toAddress,emailText,emailSubject,loggerName)
											emailsList = []
											if toAddress in staffEmailDict:
												emailsList = staffEmailDict[toAddress]
											else:
												emailsList = []
											
											emailsList.append(emailText)
											
											staffEmailDict[toAddress] = emailsList
											## add task in table
											insertQ = "INSERT INTO participant.Tasks (participantId, taskTypeId, title, dueDate, staffId, assignerId, priority, statusId, notes, timeCreated) VALUES (?,?,?,?,?,?,?,?,?, CURRENT_TIMESTAMP)"
											param = [participantId, taskTypeId, taskSubject, taskDueDateFormated, staffId, assignerId, taskPriorityId, statusId, taskNotes]
											newTaskId = system.db.runPrepUpdate(insertQ, param, getKey = 1)
	#										print(param)	
	
	# Iterate over the dict and send emails.
	for toAddress, emails in staffEmailDict.items():
		if len(emails) > 0:
			emailTextToSend = emailText = """<HTML><BODY>
				Tasks assignments for you :
				<table style=\"border-collapse: collapse; width: 100%;\">
				<tr>
			    	<th style=\"border: 1px solid black; padding: 10px;\">Subject</th>
			    	<th style=\"border: 1px solid black; padding: 10px;\">Task Type</th>
			   		<th style=\"border: 1px solid black; padding: 10px;\">Participant</th>
			   		<th style=\"border: 1px solid black; padding: 10px;\">Notes</th>
			   		<th style=\"border: 1px solid black; padding: 10px;\">Assigner</th>
			   		<th style=\"border: 1px solid black; padding: 10px;\">Staff</th>
			   		<th style=\"border: 1px solid black; padding: 10px;\">Priority</th>
			   		<th style=\"border: 1px solid black; padding: 10px;\">Due Date </th>

			  	</tr>
			  """
			for oneEmailRow in emails:
				emailTextToSend = emailTextToSend + oneEmailRow
			emailTextToSend = emailTextToSend + "</table></BODY></HTML>"
			loggerName = "Automated Tasks assignment"
			send_email(toAddress,emailTextToSend,"Tasks Assignements",loggerName)
			