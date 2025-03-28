def replace_char(value):
	#Replace # and ? with zeros
	input = str(value)
	output = ''
	for char in range(len(str(value))):
		test = input[char]
		if test == '?':
			output = output + input[char].replace('?','0')
		elif test == '#':
			output = output + input[char].replace('#','0')
		else:
			output = output + input[char]
	return output
#
#
#
def remove_char(value):
	#Remove non-numeric charcacters
	input = str(value)
	output = ''
	for char in range(len(str(value))):
		test = input[char]
		if test.isnumeric():
			output = output + input[char]
	return output

def ssn(value):
	ssn_in = str(value)
	ssn_replace = replace_char(ssn_in)
	ssn_remove = remove_char(ssn_replace)
	#Value should be numeric at this point. If not default to zeros
	#Otherwise left fill with zeros
	if ssn_remove.isnumeric():
		ssn_out = ssn_remove.zfill(9)
	else:
		ssn_out = '000000000'
	return ssn_out
	
def phone(value):
	phone_in = str(value)
	phone_remove = remove_char(phone_in)
	#Value should be numeric at this point. If not default to zeros
	#Otherwise left fill with zeros
	if phone_remove.isnumeric():
		phone_out = phone_remove.zfill(10)
	else:
		phone_out = '0000000000'
	return phone_out
