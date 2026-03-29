FUNCTION DeclaredMethodListClass(classToCheck AS SYMBOL) AS ARRAY STRICT
	
	LOCAL allMethodsArray := MethodListClass(classToCheck) AS ARRAY
	LOCAL methodsArray := {} AS ARRAY
	LOCAL index := 0 AS DWORD
	
	FOR index := 1 TO CountItems(allMethodsArray)
		IF !IsInheritedMethod(classToCheck, allMethodsArray[index])
			AddItem(methodsArray, allMethodsArray[index])
		ENDIF
	NEXT
	
RETURN methodsArray
FUNCTION HasValidInterfaceImplementations(classToValidate AS SYMBOL, validationOutput AS ValidationResultModel) AS LOGIC
	
	LOCAL potentialInterface as STRING
	LOCAL methodToValidate as STRING
	LOCAL methods as EncapsulatedArray
	LOCAL methodIterator as ArrayIterator
	LOCAL methodsValidationResult AS ValidationResultModel
	LOCAL propertiesValidationResult AS ValidationResultModel
	
	methods := EncapsulatedArray{DeclaredMethodListClass(classToValidate)}
	methodIterator := ArrayIterator{methods}
	
	DO WHILE methodIterator:HasNext
		methodToValidate := AsString(methodIterator:NextElement())
		IF Left(methodToValidate, 2) == "AS"
			potentialInterface := "I" + Right(methodToValidate, Len(methodToValidate) - 2)
			methodsValidationResult := ValidateInterfaceMethods(classToValidate, AsSymbol(potentialInterface))
			validationOutput:Errors:AddRange(methodsValidationResult:Errors)
			IF !methodsValidationResult:IsValid
				RETURN FALSE
			ENDIF
			propertiesValidationResult := ValidateInterfaceProperties(classToValidate, AsSymbol(potentialInterface))
			validationOutput:Errors:AddRange(propertiesValidationResult:Errors)
			IF !propertiesValidationResult:IsValid
				RETURN FALSE
			ENDIF
		ENDIF
	ENDDO
	
RETURN TRUE
FUNCTION IsInheritedMethod(classToCheck AS SYMBOL, methodToCheck AS SYMBOL) AS LOGIC STRICT
	
	LOCAL parentClassSymbols := ClassTreeClass(classToCheck) AS ARRAY
	LOCAL index AS DWORD
	
	FOR index := 1 TO CountItems(parentClassSymbols)
		IF classToCheck == parentClassSymbols[index]
			LOOP
		ENDIF
		IF IsMethodClass(parentClassSymbols[index], methodToCheck)
			RETURN TRUE
		ENDIF
	NEXT
	
RETURN FALSE
FUNCTION TestIfAllClassesHaveValidInterfaceImplementations(validationOutput AS ValidationResultModel)
	LOCAL classes as EncapsulatedArray
	LOCAL classIterator as ArrayIterator
	LOCAL reflectedClass as USUAL
	
	classes := EncapsulatedArray{ClassList()}
	classIterator := ArrayIterator{classes}
	DO WHILE classIterator:HasNext
		reflectedClass := classIterator:NextElement()
		IF !IsClass(reflectedClass)
			LOOP
		ENDIF
		
		IF !HasValidInterfaceImplementations(reflectedClass, validationOutput)
			validationOutput:AddValidationError("Incomplete class implementation: " + AsString(reflectedClass))
		ENDIF
	ENDDO
RETURN validationOutput:IsValid
FUNCTION ValidateInterfaceMethods(classToValidate AS SYMBOL, targetInterface AS SYMBOL) AS ValidationResultModel STRICT
	
	LOCAL interfaceMethods := MethodListClass(targetInterface) AS ARRAY
	LOCAL validationResult := ValidationResultModel{} AS ValidationResultModel
	LOCAL methodToValidate AS SYMBOL
	LOCAL index := 0 AS DWORD
	
	FOR index := 1 TO CountItems(interfaceMethods)
		methodToValidate := interfaceMethods[index]
		IF methodToValidate == #INIT
			LOOP
		ENDIF
		IF !IsMethodClass(classToValidate, methodToValidate)
			validationResult:AddValidationError(FormatString(;
				"{0} does not implement {1}:{2}", {;
				classToValidate, targetInterface, methodToValidate;
			}))
		ENDIF
	NEXT
	
RETURN validationResult
FUNCTION ValidateInterfaceProperties(;
	classToValidate AS SYMBOL, targetInterface AS SYMBOL;
) AS ValidationResultModel STRICT
	
	LOCAL interfaceProperties := IVarListClass(targetInterface) AS ARRAY
	LOCAL validationResult := ValidationResultModel{} AS ValidationResultModel
	LOCAL propertyToValidate AS SYMBOL
	LOCAL index := 0 AS DWORD
	
	FOR index := 1 TO CountItems(interfaceProperties)
		propertyToValidate := interfaceProperties[index]
		IF !IsTableClassWithColumn(classToValidate, propertyToValidate)
			validationResult:AddValidationError(FormatString(;
				"{0} does not have a database field for {1}:{2}", {;
				classToValidate, targetInterface, propertyToValidate;
			}))
		ENDIF
	NEXT
	
RETURN validationResult
METHOD AsString() CLASS ValidationResultModel
	LOCAL descriptionItems := STRINGList{} AS STRINGList
	descriptionItems:Add(FormatString("{0} with errors:", {ClassName(SELF)}))
	descriptionItems:Add("{")
	descriptionItems:AddRange(SELF:Errors)
	descriptionItems:Add("}")
RETURN JoinStringList(CRLF, descriptionItems)
FUNCTION IsTableClassWithColumn(className AS SYMBOL, fieldName AS SYMBOL) AS LOGIC STRICT
RETURN IsMethodClass(className, AsSymbol(FormatString("GetFieldInfo{0}", {fieldName})))
