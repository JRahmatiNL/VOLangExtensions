CLASS IAbstractInfoHandler INHERIT Interface
DECLARE METHOD AddInfo
METHOD AddInfo(infoToAdd AS STRING) AS USUAL STRICT CLASS IAbstractInfoHandler
RETURN Send(SELF:_implement, GetCurrentMethodName(), infoToAdd)
