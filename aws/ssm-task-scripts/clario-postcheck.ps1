## Global Vars ##
$ClusterHealth = (Get-ClusterGroup -Name "Cluster Group" | Select -ExpandProperty State)
$WitnessHealth = (Get-ClusterResource "File Share Witness" | select -ExpandProperty State)
$ProdAGOwnerName = (Get-ClusterGroup -Name "*PROD_AG" | Select -ExpandProperty OwnerNode | Select -ExpandProperty Name)
$ProdAGState = (Get-ClusterGroup -Name "*PROD_AG" | Select -ExpandProperty State)
$SessAGOwnerName = (Get-ClusterGroup -Name "*SESS_AG" | Select -ExpandProperty OwnerNode | Select -ExpandProperty Name)
$SessAGState = (Get-ClusterGroup -Name "*SESS_AG" | Select -ExpandProperty State)
## Global Cluster Health Checks

if ($WitnessHealth -eq "Online"){
    Write-Output "Witness Health: $WitnessHealth"
     }
if ($ClusterHealth -eq "Online"){
    Write-Output "Cluster Health: $ClusterHealth"
    }
elseif ($WitnessHealth -eq "PartialOnline"){
    Write-Error "Cluster in PartialOnline status. Witness likely offline"
    Exit 1
    }
elseif ($WitnessHealth -eq "Offline"){
    Write-Error "Cluster is Offline"
    Exit 1
    }
else {
   Write-Error "Invalid Cluster State Detected"
   Exit 1
   }

## Check DB server Specific health
$isDB = "DB" #DB, WEB, or SVCS
$computer = $env:computername
if ($computer.contains($isDB))
{
    if ($ProdAGOwnerName -ne $computer){
        Write-Output "Production AG state: $ProdAGState"
        }
    else {
        Write-Error "$ProdAGOwnerName is also the primary owner node, and cannot proceed."
        #TODO: Need failover steps here
        Exit 1
        }
    if ($SessAGOwnerName -ne $computer){
        Write-Output "Session AG state: $SessAGState"
        }
    else {
        Write-Error "$SessAGOwnerName is also the primary owner node, and cannot proceed."
        #TODO: Need failover steps here as well.
        Exit 1
    }
}