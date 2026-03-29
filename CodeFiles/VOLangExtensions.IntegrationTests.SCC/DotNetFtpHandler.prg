CLASS DotNetFtpHandler
// This class is intentionally incomplete in order to make it surface through the interface validation functions!
DECLARE METHOD IsConnected
DECLARE METHOD ConnectRemoteByFtpId
DECLARE METHOD CloseRemote
DECLARE METHOD SetCurDir
HIDDEN _connectedFtpId AS STRING
HIDDEN _baseRemotePath AS STRING
DECLARE METHOD GetDirectory
DECLARE METHOD AsAbstractFtpHandlerByFtpId
METHOD AsAbstractFtpHandlerByFtpId() AS IAbstractFtpHandlerByFtpId STRICT CLASS DotNetFtpHandler
RETURN IAbstractFtpHandlerByFtpId{SELF}
METHOD CloseRemote() AS LOGIC STRICT CLASS DotNetFtpHandler
	_connectedFtpId := ""
RETURN TRUE
METHOD ConnectRemoteByFtpId(bakeItId AS STRING) AS ValidationResultModel STRICT CLASS DotNetFtpHandler
	LOCAL validationResult := ValidationResultModel{} AS ValidationResultModel
	_connectedFtpId := ""
	IF TRUE // VOCSService:TestFtpConnectionById(bakeItId)
		_connectedFtpId := bakeItId
	ENDIF
	IF !SELF:IsConnected()
		validationResult:AddValidationError("Could not establish ftp connection. See logs for info!")
	ENDIF
RETURN validationResult
METHOD GetDirectory(pattern AS STRING) AS LOGIC STRICT CLASS DotNetFtpHandler
RETURN FALSE
METHOD IsConnected AS LOGIC STRICT CLASS DotNetFtpHandler
RETURN !Empty(_connectedFtpId)
METHOD SetCurDir(baseRemotePath AS STRING) AS LOGIC STRICT CLASS DotNetFtpHandler
	_baseRemotePath := baseRemotePath
RETURN TRUE
