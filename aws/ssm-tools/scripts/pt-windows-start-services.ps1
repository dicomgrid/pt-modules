try {

    function Start-Mirth {
        ### Start Mirth Service if present and not disabled
        $mirth = get-service -name "mirth*" | select -expandproperty starttype | get-unique
        if ($mirth -ne $null) {
            get-service -name $mirth | start-service
            Write-Host "Finished attempting to start Mirth services"
        }
    }

    function Start-Clario {
        ### Start Clario Services if present and 3x
        $CLSVC = Get-WmiObject win32_service | ?{$_.DisplayName -like 'zvision*'} | select -expandproperty Description
        $CLSVCVer = $CLSVC -replace '^([^-]*- )','' | get-unique
        if ($CLSVCVer -like "3.*"){
            get-service -displayname "zvision*" | start-service
            Write-Host "Finished attempting to start Clario services"
        }
    }

    function Start-CorePoint {
        ### Start Corepoint Services if present
        $CorePoint = get-service -name "corepoint*" | select -expandproperty Description
        if ($CorePoint -ne $null) {
            get-service -displayname $CorePoint | start-service
            Write-Host "Finished attempting to start CorePoint services"
        }
    }
    
    function Start-MModal {
        ### Start MModal Services if present
        $mmodal = get-service -displayname "Connexion*" | start-service
        if ($mmodal -ne $null) {
            get-service -displayname "Connexion*" | start-service
            get-service -displayname "CdsProxyCleanupServices" | start-service
            get-service -displayname "FDSupport" | start-service #M*Modal
            get-service -displayname "ISCAgent" | start-service
            Write-Host "Finished attempting to start MModal services"
        }
    }

    function Start-Mckesson {
        ### Start Mckesson Services if on main application servers and check status (K251)
        if ($env:computername -like "K251AAIO*"){
            cmd /c startweb
            cmd /c machcheck
            Write-Host "Finished attempting to start Mckesson services"
        }
    }

    ### ADD MORE SERVICES AS NEEDED

    Start-Clario
    Start-Mirth
    Start-CorePoint
    Start-MModal
    Start-Mckesson
    Write-Host "End of Execution."
}
    
catch {
        $_
}