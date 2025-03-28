import __future__
import ast

def evalExpression(inputString):
	"""
	Evaluates a math expression using python's eval() and returns the result.
	Python's eval() function is inherently dangerous as it executes aribitrary python code
	passed to it. To secure eval() we can disallow the use of any python modules or functions
	by both:
	- Providing empty builtins and globals dictionaries
	- Ensure only permitted operators/functions are present in the expression
	Uses the python AST module
	"""
	# Treat the XOR binary operator '^' as the exp operator '**'
	inputString = str(inputString).replace("^", "**")
	
	# Create an Abstract Syntax Tree from the input expression
	# If a syntax error exists then None is returned
	try:
		tree = ast.parse(inputString, mode="eval")
	except:
		return None
	
	# Only permits Unary, Arithmetic, and Binary operators in the expression
	if not all(isinstance(node, (ast.Expression,
			ast.UnaryOp, ast.unaryop,
			ast.BinOp, ast.operator,
			ast.Num)) for node in ast.walk(tree)):
		return None
	
	# Compile the AST into bytecode. Supplying the division compiler flag ensures floating point division is used instead of integer division
	code = compile(tree, "", "eval", __future__.division.compiler_flag)
	
	# Evaluate the expression and catch any runtime errors
	try:
		result = eval(code, {"__builtins__": {}}, {})
	except:
		return None
	return result
