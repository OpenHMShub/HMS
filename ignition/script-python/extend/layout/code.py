def getRoomMatrixFromList(rowSize, colSize, roomLayoutList):
	"""Get matrix (list of list) with size rowSize x colSize.
	
	Arguments:  
		rowSize (int): number of rows in room layout
		colSize (int): number of columns in room layout
		roomLayoutList (list of dictionaries): every dictonary represent one bed position, orientation ...
	Return:
		matrix (list of list):
		
	Example:
		rowSize = 5
		colSize = 3
		roomLayoutList= [{"isVertical":false,"isUpper":false,"bedId":86,"position":"C1"},{"isVertical":false,"isUpper":true,"bedId":85,"position":"C1"},{"isVertical":false,"isUpper":false,"bedId":87,"position":"C2"}
						,{"isVertical":true,"isUpper":true,"bedId":89,"position":"C3"},{"isVertical":true,"isUpper":false,"bedId":88,"position":"C3"},{"isVertical":false,"isUpper":false,"bedId":90,"position":"C5"}
						,{"isVertical":false,"isUpper":false,"bedId":92,"position":"B1"},{"isVertical":false,"isUpper":true,"bedId":91,"position":"B1"},{"isVertical":false,"isUpper":false,"bedId":93,"position":"B2"}
						,{"isVertical":true,"isUpper":false,"bedId":98,"position":"B3"},{"isVertical":true,"isUpper":true,"bedId":97,"position":"B3"},{"isVertical":false,"isUpper":false,"bedId":100,"position":"B4"}
						,{"isVertical":false,"isUpper":true,"bedId":99,"position":"B4"},{"isVertical":false,"isUpper":false,"bedId":94,"position":"B5"},{"isVertical":true,"isUpper":false,"bedId":96,"position":"A3"}
						,{"isVertical":true,"isUpper":true,"bedId":95,"position":"A3"}]
						
		matrix = 	[
			 [{},							{"type":"h","beds":[91,92]},	{"type":"h","beds":[85,86]}	]
			,[{},							{"type":"h","beds":[93]},		{"type":"h","beds":[87]}	]
			,[{"type":"v","beds":[95,96]},	{"type":"v","beds":[97,98]},	{"type":"v","beds":[89,88]}	]
			,[{},							{"type":"h","beds":[99,100]},	{}							]
			,[{},							{"type":"h","beds":[94]},		{"type":"h","beds":[90]}	]
		]


	"""
	
	import string
	colPossibleLetters = list(string.ascii_uppercase)[:colSize]
	
	# matrix empty 3x5: [[{}.{},{}],[{}.{},{}],[{}.{},{}],[{}.{},{}],[{}.{},{}]]
	matrix = [[{} for x in range(colSize)] for j in range(rowSize)]
	
	for item in roomLayoutList:
		bedId = item['bedId']
		bedType = 'v' if item['isVertical'] else 'h' 
		isUpper = item['isUpper']
	
		position = item['position'] 
		posLetter = ''.join([char for  char in position if char.isalpha()])
		posCol = colPossibleLetters.index(posLetter)
		posRow = int(position[len(posLetter):]) - 1
		
		if matrix[posRow][posCol] == {}:
			matrix[posRow][posCol]['type'] = bedType
			matrix[posRow][posCol]['beds'] = [bedId]
		else:
			if isUpper: 
				matrix[posRow][posCol]['beds'].insert(0,bedId)
			else:
				matrix[posRow][posCol]['beds'].append(bedId)
	
	return matrix
	
