METHOD Start() CLASS App
	
	LOCAL console := TermConsole{} AS TermConsole
	LOCAL validationOutput := ValidationResultModel{} AS ValidationResultModel
	
	console:WriteLine("Validating interfaces ...")
	DO CASE
	CASE !TestIfAllClassesHaveValidInterfaceImplementations(validationOutput)
		console:WriteLine("One or more errors occured while validating interfaces:")
		console:WriteLine(JoinStringList(CRLF, validationOutput:Errors))
		console:Wait()
	ENDCASE
	
	console:WriteLine("Done validating interfaces")
	console:Wait()
	
RETURN TRUE
