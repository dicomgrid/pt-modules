try {
    $Clussvc = $null
    $Clussvc = get-service -name 'Clussvc*' | select -expandproperty status
    if ($null -ne $Clussvc){
        $Node = get-clusternode | select -expandproperty name | ?{$_ -ne $env:computername}
        $MoveClusterError = $null
        Write-Host "Attempting to evacuate cluster node."
        Invoke-Expression 'Move-ClusterGroup -name "Cluster Group" -Node $Node' -ErrorVariable MoveClusterError
        if ([string]::IsNullOrEmpty($MoveClusterError)) {
            Write-Host "Finished attempting to evacuate cluster node."
            $SQLAG = $null
            $SQLAG =  get-clustergroup -name '*ag*' | select -expandproperty name
            if ($null -ne $SQLAG){
                Write-Host "DB Server detected."
                #Create Credential for SQL Server access
                [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
                Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force > /dev/null
                Install-Module -Name aws.tools.installer -Force > /dev/null
                Install-AWSToolsModule AWS.Tools.SecretsManager -Force > /dev/null
                $SecretARN = "arn:aws:secretsmanager:us-east-2:959946720450:secret:test/service-accounts/test01-4rH69h"
                $SV = (Get-SECSecretValue $SecretARN -Region us-east-2 -Select SecretString | ConvertFrom-Json | Select -ExpandProperty User)
                $SVPW = (Get-SECSecretValue $SecretARN -Region us-east-2 -Select SecretString | ConvertFrom-Json | Select -ExpandProperty Password)
                $SecurePW = ConvertTo-SecureString $SVPW -AsPlainText -Force > /dev/null
                $SVPW = $null
                $credential = New-Object System.Management.Automation.PSCredential ($SV, $SecurePW)
                Write-Host "Attempting to evacuate DB roles."
                foreach ($ag in $SQLAG){
                        $SwitchAG = (switch-sqlavailabilitygroup -path sqlserver:\sql\$Node\default\availabilitygroups\$ag | select -expandproperty healthstate)
                        Invoke-Command -ScriptBlock {$SwitchAG} -Credential $credential
                        Uninstall-AWSToolsModule AWS.Tools.SecretsManager -Force > /dev/null
                        Uninstall-Module -name aws.tools.installer -Force > /dev/null
                }
                Write-Host "Finished attempting to evacuate DB roles."
                Uninstall-AWSToolsModule AWS.Tools.SecretsManager -Force > /dev/null
                Uninstall-Module -name aws.tools.installer -Force > /dev/null
            }
        }
        else {
            Write-Host "Invalid cluster state detected. exiting..."
            exit
        } 
    }
}

catch {
    Write-Host "An unrecoverable error occurred"
    exit
}