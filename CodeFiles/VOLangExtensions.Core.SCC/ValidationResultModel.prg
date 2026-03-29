CLASS ValidationResultModel
HIDDEN _errors AS StringList
DECLARE ACCESS Errors
DECLARE ACCESS Success
DECLARE ACCESS IsValid
DECLARE METHOD AddValidationError
DECLARE METHOD AddValidationErrors
DECLARE METHOD AddValidationErrorsFrom
DECLARE METHOD Init
DECLARE METHOD WithDistinctErrors
METHOD AddValidationError(validationError AS STRING) AS VOID STRICT CLASS ValidationResultModel
	SELF:_errors:Add(validationError)
RETURN
METHOD AddValidationErrors(validationErrors AS STRINGList) AS VOID STRICT CLASS ValidationResultModel
	SELF:_errors:AddRange(validationErrors)
RETURN
METHOD AddValidationErrorsFrom(validationResult AS ValidationResultModel) AS VOID STRICT CLASS ValidationResultModel
	IF validationResult == NULL_OBJECT
		RETURN
	ENDIF
	SELF:AddValidationErrors(validationResult:Errors)
RETURN
ACCESS Errors() AS StringList STRICT CLASS ValidationResultModel
RETURN SELF:_errors
METHOD Init(errorMessages) AS ValidationResultModel STRICT CLASS ValidationResultModel
	
	SELF:_errors := STRINGList{}
	IF IsInstanceOfUsual(errorMessages, ClassName(SELF:_errors))
		SELF:_errors:AddRange(errorMessages)
	ELSE
		DEFAULT(@errorMessages,{})
		SELF:_errors := ToStringList(errorMessages)
	ENDIF
	
RETURN SELF
ACCESS IsValid() AS LOGIC STRICT CLASS ValidationResultModel
RETURN SELF:_errors:Count == 0
ACCESS SUCCESS() AS ValidationResultModel STRICT CLASS ValidationResultModel
RETURN NULL_OBJECT

METHOD WithDistinctErrors() AS ValidationResultModel STRICT CLASS ValidationResultModel
	LOCAL newResult := ValidationResultModel{} AS ValidationResultModel
	LOCAL originalValidationErrors := SELF:Errors AS STRINGList
	LOCAL errorIndex AS DWORD
	
	FOR errorIndex := 1 TO originalValidationErrors:Count
		IF newResult:Errors:Contains(originalValidationErrors:Get(errorIndex))
			LOOP
		ENDIF
		newResult:AddValidationError(originalValidationErrors:Get(errorIndex))
	NEXT
	
RETURN newResult
