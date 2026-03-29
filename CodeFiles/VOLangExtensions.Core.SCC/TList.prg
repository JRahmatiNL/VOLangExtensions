STATIC FUNCTION CompareForSort(comparer AS Comparer, x, y) AS LOGIC STRICT
RETURN comparer:Compare(x, y)
CLASS TList
PROTECT _items := {} AS ARRAY
DECLARE ACCESS Items
DECLARE METHOD _Add
DECLARE METHOD _AddRange
DECLARE METHOD _Get
DECLARE METHOD _Set
DECLARE METHOD _Contains
DECLARE METHOD _IndexOf
DECLARE METHOD Remove
DECLARE METHOD RemoveLast
DECLARE METHOD Clear
DECLARE ACCESS Count
EXPORT Counter AS DWORD
DECLARE METHOD FindIndex
DECLARE METHOD HasAny
DECLARE METHOD Sort
PROTECT METHOD _Add(itemToAdd AS USUAL) AS VOID STRICT CLASS TList
	AddItem(_items, itemToAdd)
RETURN
PROTECT METHOD _AddRange(listToAdd AS TList) AS ARRAY STRICT CLASS TList
RETURN AddRange(_items, listToAdd:Items)

PROTECT METHOD _Contains(itemToFind AS USUAL) AS LOGIC STRICT CLASS TList
RETURN ContainsItem(_items, itemToFind)
PROTECT METHOD _Get(itemIndex AS DWORD) AS USUAL STRICT CLASS TList
RETURN _items[itemIndex]
PROTECT METHOD _IndexOf(itemToFind AS USUAL) AS DWORD CLASS TList
RETURN IndexOfItem(_items, itemToFind)
PROTECT METHOD _Set(itemIndex AS DWORD, valueToSet AS USUAL) AS USUAL STRICT CLASS TList
RETURN _items[itemIndex] := valueToSet

METHOD Clear() AS VOID STRICT CLASS TList
	_items := {}
RETURN
ACCESS Count() AS DWORD STRICT CLASS TList
RETURN CountItems(_items)

METHOD FindIndex(predicate AS CODEBLOCK) AS DWORD STRICT CLASS TList
	
	LOCAL index := 0 AS DWORD
	
	FOR index := 1 TO SELF:Count
		IF Eval(predicate, SELF:_Get(index))
			RETURN index
		ENDIF
	NEXT
	
RETURN 0
METHOD HasAny(predicate AS CODEBLOCK) AS LOGIC STRICT CLASS TList
RETURN SELF:FindIndex(predicate) != 0
ACCESS Items() AS ARRAY STRICT CLASS TList
RETURN SELF:_items
METHOD Remove(itemToRemoveByIndex AS DWORD) AS LOGIC STRICT CLASS TList
RETURN RemoveItemAt(_items, itemToRemoveByIndex)
METHOD RemoveLast() AS LOGIC STRICT CLASS TList
RETURN SELF:Remove(SELF:Count)

METHOD Sort(comparer AS Comparer) AS VOID STRICT CLASS TList
	ASort(SELF:_items,,, {|x, y| CompareForSort(comparer, x, y)})
RETURN
