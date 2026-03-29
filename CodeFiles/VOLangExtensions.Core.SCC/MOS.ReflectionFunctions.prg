FUNCTION GetCurrentMethodName() AS SYMBOL STRICT
RETURN AsSymbol(SplitToStringList(AsString(ProcName(1)), ":", FALSE):Get(2))
