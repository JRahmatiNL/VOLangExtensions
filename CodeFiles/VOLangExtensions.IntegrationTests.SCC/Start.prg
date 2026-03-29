METHOD Start() CLASS App
	
	LOCAL mainApp := MainApplication{} AS MainApplication
	LOCAL mainAppAbstraction := mainApp:AsAbstractApplicationRunner() AS IAbstractApplicationRunner
	
	mainAppAbstraction:Run("Integration tests sample app")
	
RETURN TRUE
CLASS IAbstractApplicationRunner INHERIT Interface
DECLARE METHOD Run
METHOD Run(appNameToUse AS STRING) AS VOID STRICT CLASS IAbstractApplicationRunner
	Send(SELF:_implement, GetCurrentMethodName(), appNameToUse)
RETURN
CLASS MainApplication
DECLARE METHOD AsAbstractApplicationRunner
DECLARE METHOD Run
METHOD Run(appNameToUse AS STRING) AS VOID STRICT CLASS MainApplication
	LOCAL console := TermConsole{} AS TermConsole
	LOCAL validationOutput := ValidationResultModel{} AS ValidationResultModel
	
	console:Title := appNameToUse
	console:WriteLine("Validating interfaces ...")
	DO CASE
	CASE !TestIfAllClassesHaveValidInterfaceImplementations(validationOutput)
		console:WriteLine("One or more errors occured while validating interfaces:")
		console:WriteLine(JoinStringList(CRLF, validationOutput:Errors))
		console:Wait()
	ENDCASE
	
	console:WriteLine("Done validating interfaces")
	console:Wait()
	
RETURN
METHOD AsAbstractApplicationRunner() AS IAbstractApplicationRunner STRICT CLASS MainApplication
RETURN IAbstractApplicationRunner{SELF}
