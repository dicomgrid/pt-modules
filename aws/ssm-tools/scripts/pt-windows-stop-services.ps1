try {
    ### Stop Mirth Service if present
    get-service "mirth*" | stop-service 

    ### Stop Clario Services if present (Versions 3.x ONLY)
    $CLSVC = Get-WmiObject win32_service | ?{$_.DisplayName -like 'zvision*'} | select -expandproperty Description
    $CLSVCVer = $CLSVC -replace '^([^-]*- )','' | get-unique
    if ($CLSVCVer -like "3.*"){ 
    get-service -displayname "zvision*" | stop-service
    get-service -displayname "zvision*" | set-service -startuptype manual
    }

    ### Stop Corepoint Services if present
    get-service -displayname "corepoint*" | stop-service

    ### Stop Mckesson Services if present (K251)
    if ($env:computername -like "K251AAIO*"){cmd /c stopweb}

    ### ADD MORE SERVICES AS NEEDED
}

catch {
        $_
}