METHOD Start() CLASS App
	LOCAL console := TermConsole{} AS TermConsole
	console:WriteLine("Starting tests")
	console:Wait()
RETURN TRUE
