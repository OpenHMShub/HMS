import traceback
project = 'RITI'

def autoEnroll(participantId):
	logger = system.util.getLogger("Participants.autoEnroll()")
	try:
		#Get the programs that are currently set for Auto Enroll
		#Get the programs that are currently set for Auto Enroll
		path = "Participants/Enrollments/getAutoEnrollPrograms"
		autoEnrollPrograms = system.dataset.toPyDataSet(system.db.runNamedQuery(project=project,path=path))
		#Enroll the participant in each auto enroll program
		for program in autoEnrollPrograms:
			programId = program["id"]
			#print programId
			path = "Participants/Enrollments/ParticipantAddSelectedEnrollments"
			parameters = {"participantId":participantId,"programId":programId}
			try:
				enrollment = system.db.runNamedQuery(project=project,path=path,parameters=parameters)
				

			except:
				msg = traceback.format_exc()
				logger.error(msg)

	except:
		
		msg = traceback.format_exc()
		logger.error(msg)
def recreateLocationAliases():
	selectQ = """
	SELECT  l.name
		FROM participant.EventLocations l LEFT JOIN
		participant.EventLocationsAliases la
		ON la.locationName = l.name
		
		ORDER by CAST(substring(la.locationAlias, 4,len(la.locationAlias)) AS INT)
	"""
#	selectQ = "SELECT name from [participant].[EventLocations] ORDER BY name"
	locations = system.db.runQuery(selectQ)
	
	deleteQ = "DELETE FROM [participant].[EventLocationsAliases] WHERE locationName is not NULL;"
	
	insertQ = "INSERT INTO [participant].[EventLocationsAliases] (locationAlias, locationName) VALUES "
	if locations is not None and locations.getRowCount() > 0:
		for i in range(locations.getRowCount()):
			locationAlias = "loc" + str(i+1)
			locationName = locations.getValueAt(i,'name')
			insertQ = insertQ + "('" + locationAlias + "','" + locationName + "'),"
		insertQ = insertQ[:-1]
				
		system.db.runUpdateQuery(deleteQ)
		system.db.runUpdateQuery(insertQ)

def updateLocationAliases(newList):

	locations = newList
	
	deleteQ = "DELETE FROM [participant].[EventLocationsAliases] WHERE locationName is not NULL;"
	
	insertQ = "INSERT INTO [participant].[EventLocationsAliases] (locationAlias, locationName) VALUES "
	if locations is not None and len(locations) > 0:
		for i in range(len(locations)):
			locationAlias = "loc" + str(i+1)
			locationName = locations[i]
			insertQ = insertQ + "('" + locationAlias + "','" + locationName + "'),"
		insertQ = insertQ[:-1]
				
		system.db.runUpdateQuery(deleteQ)
		system.db.runUpdateQuery(insertQ)
