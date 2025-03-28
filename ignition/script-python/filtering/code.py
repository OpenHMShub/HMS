import re

""" This is taking a DataSet returned from the Named Query """
def doFilter(data, filterList=None):
	
	if not filterList:
		return data
	
	pDS = system.dataset.toPyDataSet(data)
	hdr = list(pDS.getColumnNames())
	
	filteredData = pDS
	for filter in filterList:
		filterType = filter.type
		columnName = filter.key
		searchValue = filter.value
		
		if filterType == "like": 
			filteredData = filterLike(searchValue, columnName, filteredData)
		if filterType == "match": 
			filteredData = filterMatch(searchValue, columnName, filteredData)
		if filterType == "full_text": 
			filteredData = filterFullText(searchValue, columnName, filteredData)
		if filterType == "date":
			filteredData = filterDate(searchValue, columnName, filteredData)
		if filterType == "minBound":
			filteredData = filterMinBound(searchValue, columnName, filteredData)
		if filterType == "maxBound":
			filteredData = filterMaxBound(searchValue, columnName, filteredData)
		if filterType == "multi":
			filteredData = filterMulti(searchValue, columnName, filteredData)
		if filterType == "empty":
			filteredData = filterNull(searchValue, columnName, filteredData)
	
	return system.dataset.toDataSet(hdr, filteredData)


### Supporting Methods Below ###

def filterLike(searchValue, columnName, pDS):
	pattern = re.escape(str(searchValue))
	return filter(lambda x: re.search(pattern, str(x[columnName]), re.IGNORECASE), pDS)


def filterMatch(searchValue, columnName, pDS):
	pattern = re.escape(str(searchValue))
	return filter(lambda x: re.match(pattern, str(x[columnName]), re.IGNORECASE), pDS)


def filterFullText(searchValue, columnName, pDS):
	pattern = re.escape(str(searchValue))
	return filter(lambda row: any(re.search(pattern, str(column), re.IGNORECASE) for column in row), pDS)


def filterDate(searchValue, columnName, pDS):
	pattern = str(searchValue)
	#return filter(lambda x: re.match(pattern, system.date.format(x[columnName], "MM/dd/yyyy"), re.IGNORECASE), pDS)
	return filter(lambda x: re.match(pattern, x[columnName], re.IGNORECASE), pDS)


def filterMinBound(searchValue, columnName, pDS):
	return filter(lambda x: int(x[columnName]) <= int(searchValue), pDS)


def filterMaxBound(searchValue, columnName, pDS):
	return filter(lambda x: int(x[columnName]) >= int(searchValue), pDS)


def filterMulti(searchValue, columnName, pDS):	
	combinedData = []
	
	for item in searchValue:
		pattern = re.escape(str(item))
		filteredData = filter(lambda x: re.match(pattern, str(x[columnName]), re.IGNORECASE), pDS)
		
		combinedData.extend(filteredData)
		
	return combinedData


def filterNull(searchValue, columnName, pDS):
	try:
		return filter(lambda x: x[columnName] is None, pDS)
	except Exception as e:
		system.perspective.print(e)	
