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
    
        Write-Host "DONE"
        #Fetch Availability Groups
        Write-Host "Detecting SQL Roles..."
        [reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") | out-null
        $svr = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $env:computername;
        $svr.ConnectionContext.StatementTimeout = 0;
        
        #Move Availability Groups to this node
        foreach ($AvailabilityGroup in $svr.AvailabilityGroups){
            Write-Host "SQL Availability Group detected >>> $($AvailabilityGroup.Name):"
            $currenthost = $null
            $currenthost = $($AvailabilityGroup.PrimaryReplicaServerName)
            Write-Host "The current owner node is: $currenthost..."
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
        
       
        Write-Host "DONE"
    
        }
    
    else {
        Write-Host "No Failover Cluster Roles detected. So sad... Exiting..."
        exit
    } 
    }
    
    catch {
            $_
    }
    
    finally {
        Write-Host "ALL DONE! THANK YOU FOR PLAYING!"
    }