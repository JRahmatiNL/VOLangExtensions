CLASS IAbstractFtpHandlerByFtpId INHERIT IAbstractFtpHandler
DECLARE METHOD ConnectRemoteByFtpId
DECLARE METHOD SetInfoHandler
METHOD ConnectRemoteByFtpId(ftpId AS STRING) AS ValidationResultModel STRICT CLASS IAbstractFtpHandlerByFtpId
RETURN Send(SELF:_implement, GetCurrentMethodName(), ftpId)
METHOD SetInfoHandler(infoHandler AS IAbstractInfoHandler) AS USUAL STRICT CLASS IAbstractFtpHandlerByFtpId
RETURN Send(SELF:_implement, GetCurrentMethodName(), infoHandler)
