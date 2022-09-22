## Global Vars ##
$ClusterHealth = (Get-ClusterGroup -Name "Cluster Group" | Select -ExpandProperty State)
$ClusterOwner = (Get-ClusterGroup -Name "Cluster Group" | Select -ExpandProperty OwnerNode | Select -ExpandProperty Name)
$SecondaryNode = ((Get-ClusterNode)[0] | Select-Object Name | Select -ExpandProperty Name)

$WitnessHealth = (Get-ClusterResource "File Share Witness" | select -ExpandProperty State)
$BringWitnessOnline = (Start-ClusterResource -Name "File Share Witness" -Wait 0)

$ProdAGName = (Get-ClusterGroup -Name "*PROD_AG" | Select -ExpandProperty Name)
$ProdAGOwnerName = (Get-ClusterGroup -Name "*PROD_AG" | Select -ExpandProperty OwnerNode | Select -ExpandProperty Name)
$ProdAGState = (Get-ClusterGroup -Name "*PROD_AG" | Select -ExpandProperty State)

$SessAGName = (Get-ClusterGroup -Name "*SESS_AG" | Select -ExpandProperty Name)
$SessAGOwnerName = (Get-ClusterGroup -Name "*SESS_AG" | Select -ExpandProperty OwnerNode | Select -ExpandProperty Name)
$SessAGState = (Get-ClusterGroup -Name "*SESS_AG" | Select -ExpandProperty State)

## Global Cluster Health Checks
if ($WitnessHealth -eq "Online"){
    Write-Output "Witness Health: $WitnessHealth"
    }
    elseif ($WitnessHealth -eq "Offline") {
    Write-Error "Witness is offline. Attempting to bring online..."
    Start-Sleep -s 3
    & $BringWitnessOnline
    if ($WitnessHealth -eq "Online"){
        Write-Output "Witness successfully brought back online."
    }
    else {
        Write-Error "Cannot bring Witness back online. Exiting..."
        Exit 1
    }
}

if ($ClusterHealth -eq "Online"){
    Write-Output "Cluster Health: $ClusterHealth"
    }
elseif ($WitnessHealth -eq "PartialOnline"){
    Write-Error "Cluster in PartialOnline status. Witness likely offline"
    #TODO: Need steps to resolve PartialOnline cluster status
    Exit 1
    }
elseif ($WitnessHealth -eq "Offline"){
    Write-Error "Cluster is Offline"
    #TODO: Need steps to resolve Offline cluster status
    Exit 1
    }
else {
   Write-Error "Invalid Cluster State Detected"
   Exit 1
   }

###############

## Check DB server Specific health
$isDB = "DB" #DB, WEB, or SVCS
$computer = $env:computername
if ($computer.contains($isDB)){
    if ($ClusterOwner -ne $computer){
        Write-Output "Cluster Owner: $ClusterOwner"
        if ($ProdAGOwnerName -ne $computer){
            Write-Output "Production AG state: $ProdAGState"
            }
        else {
            Write-Error "$ProdAGOwnerName is also the primary owner node, and cannot proceed."
            Move-ClusterGroup -Name $ProdAGName -Node $SecondaryNode -Wait 0
            sleep 10
            if ($ProdAGOwnerName -ne $computer){
                Write-Host "Successfully failed over Prod Availability Group."
            }
            else {
                Write-Error "Availability Group is still on primary node. Exiting..."
                Exit 1
            }
        }
        if ($SessAGOwnerName -ne $computer){
            Write-Output "Session AG state: $SessAGState"
            }
        else {
            Write-Error "$SessAGOwnerName is also the primary owner node, and cannot proceed."
            Move-ClusterGroup -Name $SessAGName -Node $SecondaryNode -Wait 0
            sleep 10
            if ($ProdAGOwnerName -ne $computer){
                Write-Host "Successfully failed over Session Availability Group."
            }
            else {
                Write-Error "Availability Group is still on primary node. Exiting..."
                Exit 1
            }
        }
    }
    elseif ($ClusterOwner -eq $computer){
        Write-Error "Cluster owner is this computer. Attempting to failover to secondary node..."
        Move-ClusterGroup -Name "Cluster Group" -Node $SecondaryNode -Wait 0
        sleep 10
        $ClusterOwner = (Get-ClusterGroup -Name "Cluster Group" | Select -ExpandProperty OwnerNode | Select -ExpandProperty Name)
        if ($ClusterOwner -ne $computer){
            Write-Host "Successfully failed over cluster."
            if ($ProdAGOwnerName -ne $computer){
                Write-Output "Production AG state: $ProdAGState"
                }
            else {
                Write-Error "$ProdAGOwnerName is also the primary owner node, and cannot proceed."
                Move-ClusterGroup -Name $ProdAGName -Node $SecondaryNode -Wait 0
                sleep 10
                if ($ProdAGOwnerName -ne $computer){
                    Write-Host "Successfully failed over Prod Availability Group."
                }
                else {
                    Write-Error "Availability Group is still on primary node. Exiting..."
                    Exit 1
                }
            }
            if ($SessAGOwnerName -ne $computer){
                Write-Output "Session AG state: $SessAGState"
                }
            else {
                Write-Error "$SessAGOwnerName is also the primary owner node, and cannot proceed."
                Move-ClusterGroup -Name $SessAGName -Node $SecondaryNode -Wait 0
                sleep 10
                if ($ProdAGOwnerName -ne $computer){
                    Write-Host "Successfully failed over Session Availability Group."
                }
                else {
                    Write-Error "Availability Group is still on primary node. Exiting..."
                    Exit 1
                }
            }
        else {
            Write-Error "Cannot failover cluster. Exiting..."
            Exit 1
            }   
        }  
    elseif ($WitnessHealth -eq "Offline"){
        Write-Error "Cluster is Offline"
        Exit 1
        }
    else {
       Write-Error "Invalid Cluster State Detected"
       Exit 1
    }   
}