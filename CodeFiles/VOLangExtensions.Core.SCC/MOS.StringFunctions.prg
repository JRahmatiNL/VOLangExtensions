GLOBAL CRLF := _chr(13)+_chr(10) AS STRING
FUNCTION FormatString(formatString AS STRING, stringArguments AS ARRAY) AS STRING STRICT
	// Description:Tries to emulate String.Format from C#.
	// For example FormatString("Name = {0}, hours = {1}", {"Jafar", 43}) will result to:
	// 		"Name = Jafar, hours = 43"
	// Note that this is a very basic implementation and that things like masks don't work!!!
	LOCAL i AS DWORD
	LOCAL finalString AS STRING
	LOCAL argument AS STRING
	
	finalString := formatString
	FOR i := 1 TO ALen(stringArguments)
		argument := AsString(stringArguments[i])
		finalString := StrTran( (finalString), ("{" + AllTrim(Str(i-1)) + "}"), (argument) ) 
	NEXT
	
RETURN finalString
FUNCTION JoinString(separator AS STRING, stringsToJoin AS ARRAY) AS STRING STRICT
	
	// Description: This is a simplified version of the String.Join functionality in C#
	LOCAL joinedString AS STRING
	LOCAL stringsIndex AS DWORD
	
	joinedString := ""
	FOR stringsIndex := 1 TO ALen(stringsToJoin)
		
		joinedString += stringsToJoin[stringsIndex]
		IF stringsIndex != ALen(stringsToJoin)
			joinedString += FormatString("{0}", {separator})
		ENDIF
		
	NEXT
	
RETURN joinedString
FUNCTION JoinStringList(separator AS STRING, stringListToJoin AS STRINGList) AS STRING STRICT
RETURN JoinString(separator, stringListToJoin:Items)
