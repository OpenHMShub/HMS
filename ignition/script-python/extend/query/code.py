def getWhereInParamFix(whereInClause, param):
	"""Return "fixed" whereInClause and params. 
	
	This function is used to correct query and provide posibilities to pass list 
	as arguments when executing runPrepQuery and similar. JDBC doesn't accept array as argument
	Main idea is to replace *? with array of question marks ?,?,?...?,?,? with length equal to len(param). 
	Special cases are param is None, returned whereInFix will be sql always true:1 = 1
	
	Arguments:  
		whereInClause (str): where in clause containinig " in (*?)"
		param ('list', 'PropertyTreeScriptWrapper$ArrayWrapper', single parameter or None)
	Return:
		(str):
	"""
	if ' in (*?)' not in whereInClause.lower():
		errMsg = 'Input parameter whereInClause {} must contain text " in (*?)"'.format(whereInClause)
		errMsg += '\nFor example: "[person].[id] in (*?)" '
		raise ValueError(errMsg)
	
	_positionOfIn = whereInClause.lower().find(' in (*?)') 
	_sqlColumn = whereInClause[:_positionOfIn]
	
	# If param is None then return sql always true 1 = 1
	if param is None:
		return '1 = 1', []
	
	# If param is not list or PropertyTreeScriptWrapper$ArrayWrapper then return =. Same will be with: in (?)
	if type(param).__name__ not in ('list', 'PropertyTreeScriptWrapper$ArrayWrapper'):
		whereInFix = '{} = ?'.format(_sqlColumn)
		return whereInFix, [param]
	
	# Following code is for type(param).__name__ in ('list', "PropertyTreeScriptWrapper$ArrayWrapper")
	if len(param) == 0:
		return '1 = 0', []
		
	else:
		_whereIsNull = ''
		if None in  param:
			paramFix = [item for item in param if item is not None]
			_whereIsNull = ' OR {} IS NULL'.format(_sqlColumn)
		else:
			paramFix = param
			
		_questionMarks = ','.join(['?']*len(paramFix))
		whereInFix = '({} in ({}){})'.format(_sqlColumn,_questionMarks,_whereIsNull)
	
		return whereInFix, paramFix


def getPrepQueryArgs(queryCore, wherePlus=None, orderby=None, useCnd=True):
	"""Return sql prepQuery and list of arguments, which are ready to use in built in function system.db.runPrepQuery(query, args, dbName).

	Values to create args (list) for prepQuery could be passed only by wherePlus.  
	
	Author: miro
	
	Arguments:
		queryCore (unicode): sql query which contain select, from and where clauses. (not orderby) 
		wherePlus (array of objects, like list of dictonaries): 
		orderby (unicode): orderby clause for sql query 
		useCnd (bool): define if only 'cnd' should be used from wherePlus. if value is false use also 'cnd' to expand where clause.
	
	Returns:
		(unicode) query: sql query as result of joining 	queryCore,orderby and jsonWherePlus
		(list) args: list of values 
	
		
	Example arguments:
		queryCore = 'SELECT [Room].[id] AS roomId, [Room].[roomName] AS Room 
						FROM [HMSOps].[lodging].[Room] 
						INNER JOIN [HMSOps].[lodging].[Facility] 
						ON [Room].[facilityId] = [Facility].[id] 
						WHERE ([Room].[timeRetired] IS NULL)' 
						
		wherePlus = [{"arg":3,"cnd":"[Facility].[id] = ?"}]
		
		orderby = '[roomName]'
		
	Example returns:
		query = 'SELECT [Room].[id] AS roomId, [Room].[roomName] AS Room 
				FROM [HMSOps].[lodging].[Room] 
				INNER JOIN [HMSOps].[lodging].[Facility] 
				ON [Room].[facilityId] = [Facility].[id] 
				WHERE ([Room].[timeRetired] IS NULL) AND ([Facility].[id] = ?) 
				ORDER BY [roomName]'
		args = [3]
	
	"""

	if not(isinstance(queryCore,basestring) and queryCore.strip() != ''):
		return None, None

	queryCore = (queryCore.replace('\t',' ')).replace('\n',' ')
	
	# Check minimum conditions for orderby (is string or unicode, not empty '' etc., 
	# and if necessary set to '1' which means sort by first column.
	if not(isinstance(orderby,basestring) and orderby.strip() != ''):
		orderby = '1'
	
	args = []
	wherePlusClause = None
	
	for x in wherePlus:
		arg = x['arg']
		if x.get('type','') == 'datetime': 
			args.append(system.date.parse(arg))
		elif isinstance(arg,list) or type(arg).__name__ == "PropertyTreeScriptWrapper$ArrayWrapper":
			args += arg
		else:
			args.append(arg)
		
		# Check if cnd should be used. Case where useCnd is False means use arguments only
		if not(useCnd):
			continue
			
		cnd = x.get('cnd')
		
		# Check If 'cnd' is missing or 'cnd' is None, this means don't add condition to wherePlusClause.In that case number of 'cnd' and number of argumensts are not same.
		# For example query: DECLARE @age INT = ? ....... WHERE [age] = @age AND [person].[firstName] = ?  ; args: [47, 'Monthy']. 
		# For this case wherePlus is: [{"cnd":None, "arg":47},{"cnd":"[person].[firstName] = ?", "arg": "Monthy"}] or [{""arg":47},{"cnd":"[person].[firstName] = ?", "arg": "Monthy"}]
			
		if cnd is None or cnd.strip() == '':
			continue
		
		# Corect cnd if only one ? and few arg		
		if (isinstance(arg,list) or type(arg).__name__ == "PropertyTreeScriptWrapper$ArrayWrapper") and cnd.count('?') != len(arg):
			# If len(arg) and number of '?' are different replace one '?' in cnd with multi '?,?,...,?' 
			qmMulti = ','.join(['?'] * len(arg))
			cnd = cnd.replace('?',qmMulti)	
				
		wherePlusClause = cnd if wherePlusClause is None else wherePlusClause + ' AND {}'.format(cnd)
	
	if wherePlusClause:
		prepQuery= "{} AND ({}) ORDER BY {}".format(queryCore, wherePlusClause, orderby)
	else:
		prepQuery= '{} ORDER BY {}'.format(queryCore, orderby)
	
	return prepQuery, args
