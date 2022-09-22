try {
    ### Start Mirth Service if present and not disabled
    $mirth = get-service -name "mirth*" | select -expandproperty starttype | get-unique
    if ($mirth -like "automatic*"){
    get-service "mirth*" | start-service
    }

    ### Start Clario Services if present (Versions 3.x ONLY)
    $CLSVC = Get-WmiObject win32_service | ?{$_.DisplayName -like 'zvision*'} | select -expandproperty Description
    $CLSVCVer = $CLSVC -replace '^([^-]*- )','' | get-unique
    if ($CLSVCVer -like "3.*"){
    get-service -displayname "zvision*" | start-service
    get-service -displayname "zvision*" | set-service -startuptype automatic
    }

    ### Start Corepoint Services if present
    get-service -displayname "corepoint*" | start-service

    ### Start Mckesson Services if present and check status (K251)
    if ($env:computername -like "K251AAIO*"){
    cmd /c startweb
    cmd /c machcheck
    }

    ### ADD MORE SERVICES AS NEEDED
}
    
catch {
        $_
}
