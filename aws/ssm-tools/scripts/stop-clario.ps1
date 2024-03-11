try {

    function Stop-Mirth {
        ### Stop Mirth Service if present
        $mirth = get-service -name "mirth*" | select -expandproperty starttype | get-unique
        if ($mirth -ne $null) {
            get-service -name $mirth | stop-service
            Write-Host "Finished attempting to stop Mirth services"
        }
    }

    function Stop-Clario {
        ### Stop Clario Services if present (Versions 3.x ONLY)
        $CLSVC = Get-WmiObject win32_service | ?{$_.DisplayName -like 'zvision*'} | select -expandproperty Description
        $CLSVCVer = $CLSVC -replace '^([^-]*- )','' | get-unique
            if ($CLSVCVer -like "3.*"){ 
            get-service -displayname "zvision*" | stop-service
            Write-Host "Finished attempting to stop Clario services"
        }
    }

    function Stop-CorePoint {
        ### Stop Corepoint Services if present
        $CorePoint = get-service -name "corepoint*" | select -expandproperty Description
        if ($CorePoint -ne $null) {
            get-service -displayname $CorePoint | stop-service
            Write-Host "Finished attempting to start CorePoint services"
        }
    }

    function Stop-MModal {
        ### Start MModal Services if present
        $mmodal = get-service -displayname "Connexion*" | start-service
        if ($mmodal -ne $null) {
            get-service -displayname "Connexion*" | stop-service
            get-service -displayname "CdsProxyCleanupServices" | stop-service
            get-service -displayname "FDSupport" | stop-service
            get-service -displayname "ISCAgent" | stop-service
        }
    }

    function Stop-Mckesson {
        ### Stop Mckesson Services if present (K251)
        if ($env:computername -like "K251AAIO*"){cmd /c stopweb}
    }

    ### ADD MORE SERVICES AS NEEDED

    Stop-Clario
    Stop-Mirth
    Stop-CorePoint
    Stop-MModal
    Stop-Mckesson
    Write-Host "End of Execution."
}

catch {
        $_
}