LIBRARY = 'vision.components.scrollable'
VERSION = '1.2'

def fixScrollSpeed(scrollableObj):
	'''
	 Description:
	 Set the scroll 'speed' from extremely slow (default) to useable
	 Usage:
		if event.propertyName in ['componentRunning', 'editor']:
			shared.components.scrollable.fixScrollSpeed(event.source)
	'''
	components = scrollableObj.getComponents()
	
	# find the embedded JideScrollPane component
	for component in components:
		if str(type(component)) == "<type 'com.jidesoft.swing.JideScrollPane'>":
			scrollPane = component
	
	size = scrollPane.getSize()
	
	# set the scroll increment for the arrows to a fraction of the height of the scrollable panel
	scrollPane.getVerticalScrollBar().setUnitIncrement(size.height/4) #scroll amount for wheel and arrows
	
	# set the scroll increment when clicking on the scrollbar track piece to the height of the scrollable panel i.e. move 1 whole 'page' up/down
	scrollPane.getVerticalScrollBar().setBlockIncrement(size.height) #scroll amount clicking on scrollbar itself

def scrollToPos(scrollableObj, DataSetFieldName, NewDataSetPosValue, position=0, recursionLevel=0):
	'''
	Description:
	Scrolls the table component to the item above the new position.
	
	Arguments:
	scrollableObj			- the scrollable component (table, power table, template repeater - untested with any others)
	DataSetFieldName		- the field name in the templateParams dataset to find the new position value in
	NewDataSetPosValue		- the field value of the field name to find in the dataset to move to
	Position				- the position to scroll to:
								0 - position item at the top minus 1
								1 - position item in the centre
								2 - position item at the top
	
	Revision:
	No.		Date		Author			Comment
	1.0		2018-11		Nick Minchin	Original
	1.1		2019-12		Nick Minchin	Simplified function. Can set value of scrollbar directly without having to use the viewport.
	1.2		2019-12-15	Nick Minchin	Simplified further method to get the scrollbar object. Added ability to change scroll to position type.
	1.3		2020-06-25	Nick Minchin	Fixed issue with rowHeight for Power Tables. Made item height and items count round up
	'''
	import math
	objType = str(type(scrollableObj))
	
	ds = None
	#get the component's items dataset so that we can work out the current index of the maximum
	if any([t in objType for t in ['PMITable', 'VisionAdvancedTable']]):
		ds = scrollableObj.data
	if any([t in objType for t in ['TemplateRepeater']]):
		ds = scrollableObj.templateParams
	
	if ds == None:
		import sys
		system.gui.messageBox("The object type you passed in is not accounted for. '%s'" % objType, 'Error')
		sys.exit()
	ds = system.dataset.toPyDataSet(ds)
	
	if len(ds) > 0:
		#find the index of the new item from the dataset
		index = 0
		for i in range(len(ds)):
			if ds[i][DataSetFieldName] == NewDataSetPosValue:
				index = i
		
		scrollBar = scrollableObj.getComponent(1).getComponent(1)#verticalScrollBar
		
		scrollBarHeight = scrollBar.height
		scrollBarMaxHeight = scrollBar.getMaximum()
		itemCount = len(ds)
		itemHeight = math.ceil((1.0*scrollBarMaxHeight)/itemCount)
		itemsInView = math.ceil((1.0*scrollBarHeight)/itemCount)
		
		#Calculate the position of the current step using the item height and the new item's index
		if position == 0:
			newPos = int(itemHeight*(index-1))
		elif position == 1:
			newPos = int(itemHeight*(index - itemsInView/2))
		else:
			newPos = int(itemHeight*(index-1))
				
		#Calculate the position of the current step using the item height and the new item's index
		if position == 0:
			newPos = int(itemHeight*(index - 1))
		elif position == 1: #WORKING
			newPos = int(itemHeight*(index + 1 - (itemsInView/2.0)))
			#newPos = int(math.ceil(itemHeight*(index  - (itemsInView/2.0))))
		elif position == 2:
			newPos = int(itemHeight*(index - 0))
		else:
			newPos = int(itemHeight*(index - 0))
		
		scrollBar.setValue(newPos)
		
		if any([t in objType for t in ['PMITable', 'VisionAdvancedTable']]):
			scrollableObj.selectedRow = index
		recursionLevel += 1
		# for some reason the first time this is run, the scroll is off by a few pixels.. so call it again
		if recursionLevel == 1:
			scrollToPos(scrollableObj, DataSetFieldName, NewDataSetPosValue, position, recursionLevel)
