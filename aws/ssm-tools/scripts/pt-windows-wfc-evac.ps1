try {
    
    Write-Host "Detecting Failover Cluster Roles..."
    $Clussvc = $null
    $Clussvc = get-service -name 'Clussvc*' | select -expandproperty status | ?{$_ -ne "Stopped"}
    if ($null -ne $Clussvc){
        # Move Cluster to this node
        Write-Host "Failover Cluster services detected!"
        $Node = get-clusternode | select -expandproperty name | ?{$_ -eq $env:computername}
        $MoveClusterError = $null
        $MoveClusterCommand = (Move-ClusterGroup -Name "Cluster Group" -Node $Node)
        Write-Host "Initiating failover attempt to this host..."
    
        Invoke-Command -ScriptBlock {$MoveClusterCommand} 
    
        Write-Host "Failover attempt completed."

        #Fetch Availability Groups
        Write-Host "Detecting SQL Roles..."
        [reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") | out-null
        $svr = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $env:computername;
        $svr.ConnectionContext.StatementTimeout = 0;
        
        #Move Availability Groups to this node
        foreach ($AvailabilityGroup in $svr.AvailabilityGroups){
            Write-Host "AG detected >>> $($AvailabilityGroup.Name):"
            $currenthost = $null
            $currenthost = $($AvailabilityGroup.PrimaryReplicaServerName)
            Write-Host "$currenthost is the current owner node"
            $SwitchAG = $null
            if ($currenthost -ne $env:computername){
                Write-Host "Initiating failover attempt to this host..."
                $SwitchAG = (switch-sqlavailabilitygroup -path "sqlserver:\sql\$Node\default\availabilitygroups\$($AvailabilityGroup.Name)" -erroraction silentlycontinue)
                $newhost = (get-clustergroup -name "$($AvailabilityGroup.Name)" | select -expandproperty ownernode | select -expandproperty name)
                Invoke-Command -ScriptBlock {$SwitchAG} -Computer $env:computername -erroraction silentlycontinue
                Start-Sleep -seconds 5
                Write-Host "Failover attempt complete. The owner node is now: $newhost"
            }
        }
       
        Write-Host "Failover complete."
    
        }
    
    else {
        Write-Host "No Failover Cluster Roles detected. Exiting..."
        exit
    } 
}
    
catch {
        $_
}

finally {
    Write-Host "Ending execution"
}