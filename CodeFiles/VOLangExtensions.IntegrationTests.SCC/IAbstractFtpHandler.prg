CLASS IAbstractFtpHandler INHERIT Interface
/* This class is meant as an interface, do not add implementations here! */
/* In order to guarantee the implementing class is valid, you will need to: */
/* 1. Add a conversion method like AsFtpHandler() that creates this interface through an Adapter class */
/* 2. Call HasValidInterfaceImplementations in a unit test */
/* Note however that this is limited to method names since reflection is very basic in VO!*/
DECLARE METHOD ListDirectory
DECLARE METHOD DeleteFile
DECLARE METHOD CloseRemote
DECLARE METHOD IsConnected
DECLARE METHOD SetCurdir
DECLARE METHOD LoadDirectoryListing
DECLARE METHOD GetLowLevel
DECLARE METHOD GetAccessType
DECLARE METHOD SetAccessType
METHOD CloseRemote() AS USUAL STRICT CLASS IAbstractFtpHandler
RETURN Send(SELF:_implement, GetCurrentMethodName())
METHOD DeleteFile(fileToDelete AS STRING) AS LOGIC STRICT CLASS IAbstractFtpHandler
RETURN Send(SELF:_implement, GetCurrentMethodName(), fileToDelete)
METHOD GetAccessType() AS DWORD STRICT CLASS IAbstractFtpHandler
RETURN Send(SELF:_implement, GetCurrentMethodName())
METHOD GetLowLevel(remoteFileName AS STRING, localFilePath AS STRING) AS USUAL STRICT CLASS IAbstractFtpHandler
RETURN Send(SELF:_implement, GetCurrentMethodName())
METHOD IsConnected() AS LOGIC STRICT CLASS IAbstractFtpHandler
RETURN Send(SELF:_implement, GetCurrentMethodName())
METHOD ListDirectory(filePattern AS STRING) AS USUAL STRICT CLASS IAbstractFtpHandler
RETURN Send(SELF:_implement, GetCurrentMethodName(), filePattern)
METHOD LoadDirectoryListing(filePattern AS STRING) AS USUAL STRICT CLASS IAbstractFtpHandler
RETURN Send(SELF:_implement, GetCurrentMethodName(), filePattern)
METHOD SetAccessType(newValue AS DWORD) AS DWORD STRICT CLASS IAbstractFtpHandler
RETURN Send(SELF:_implement, GetCurrentMethodName(), newValue)
METHOD SetCurdir(baseRemotePath AS STRING) AS LOGIC STRICT CLASS IAbstractFtpHandler
RETURN Send(SELF:_implement, GetCurrentMethodName(), baseRemotePath)
