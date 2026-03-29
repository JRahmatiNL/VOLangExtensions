FUNCTION AddItem(arrayToMutate AS ARRAY, itemToAdd AS USUAL) AS VOID STRICT
	AAdd(arrayToMutate, itemToAdd)
RETURN
FUNCTION AddRange(arrayToMutate AS ARRAY, itemsToAdd AS ARRAY) AS ARRAY STRICT
	LOCAL itemIndex AS DWORD
	FOR itemIndex := 1 TO ALen(itemsToAdd)
		AddItem(arrayToMutate, itemsToAdd[itemIndex])
	NEXT
RETURN itemsToAdd
FUNCTION ContainsItem(arrayToSearch AS ARRAY, itemToFind AS USUAL) AS LOGIC STRICT
RETURN IndexOfItem(arrayToSearch, itemToFind) > 0
FUNCTION CountItems(arrayToMeasure AS ARRAY) AS DWORD STRICT
RETURN ALen(arrayToMeasure)
FUNCTION FilterArray(arrayToFilter AS ARRAY, predicate AS CODEBLOCK) AS ARRAY STRICT
	LOCAL filteredArray := {} AS ARRAY
	LOCAL index AS DWORD
	FOR index := 1 TO CountItems(arrayToFilter)
		IF Eval(predicate, arrayToFilter[index])
			AddItem(filteredArray, arrayToFilter[index])
		ENDIF
	NEXT
RETURN filteredArray
FUNCTION IndexOfItem(arrayToSearch AS ARRAY, itemToFind AS USUAL) AS DWORD STRICT
RETURN AScan(arrayToSearch, {|x| x == itemToFind})
FUNCTION RemoveItemAt(arrayToMutate AS ARRAY, itemToRemoveByIndex AS DWORD) AS LOGIC STRICT
	IF itemToRemoveByIndex <= CountItems(arrayToMutate) 
		ADel(arrayToMutate, itemToRemoveByIndex)
		ASize(arrayToMutate, (CountItems(arrayToMutate) - 1))
		RETURN TRUE
	ENDIF
RETURN FALSE
FUNCTION ToStringList(rawArray AS ARRAY) AS STRINGList STRICT
	LOCAL listToReturn := STRINGList{} AS STRINGList
	LOCAL index := 0 AS DWORD
	FOR index := 1 TO CountItems(rawArray)
		listToReturn:Add(rawArray[index])
	NEXT
RETURN listToReturn
