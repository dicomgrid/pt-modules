## Global Vars ##
$BFServiceState = (Get-Service -Name "BlackfordPlatform" | Select -ExpandProperty Status)

if ($BFServiceState -eq "Running"){
    Write-Output "Blackford Platform Service healthy: $BFServiceState"
}
elseif ($BFServiceState -ne "Running"){
    Write-Output "Blackford Platform Service not healthy: $BFServiceState"
    Exit 1
}