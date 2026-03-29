CLASS StringList INHERIT TList
DECLARE METHOD Add
DECLARE METHOD AddRange
DECLARE METHOD Get
DECLARE METHOD Set
DECLARE METHOD Contains
DECLARE METHOD IndexOf
METHOD Add(itemToAdd AS String) AS VOID STRICT CLASS StringList
	SUPER:_Add(itemToAdd)
RETURN
METHOD AddRange(collection AS StringList) AS StringList STRICT CLASS StringList
	SUPER:_AddRange(collection)
RETURN SELF

METHOD Get(itemIndex AS DWORD) AS String STRICT CLASS StringList
RETURN SUPER:_Get(itemIndex)

METHOD Set(itemIndex AS DWORD, valueToSet AS String) AS String STRICT CLASS StringList
RETURN SUPER:_Set(itemIndex, valueToSet)

METHOD Contains(itemToFind AS String) AS LOGIC STRICT CLASS StringList
RETURN SUPER:_Contains(itemToFind)
METHOD IndexOf(itemToFind AS String) AS DWORD STRICT CLASS StringList
RETURN SUPER:_IndexOf(itemToFind)

