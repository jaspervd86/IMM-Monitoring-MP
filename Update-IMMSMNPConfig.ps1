param($ServerPath,$CommunityString,$CompanyName,$MGIP1,$MGIP2)

$Servers = get-content -path $ServerPath

$Credential = Get-Credential 

    #SNMP Commands
foreach ($Server in $Servers)
{
    $Session = New-SshSession $Server -Credential $Credential -AcceptKey
    [string]$CommandSNMPConfig = "snmp -a on -a3 on -l $Server -cn $CompanyName -c1 $CommunityString -c1i1 $MGIP1 -c1i2 $MGIP2 -ca1 get -ca2 get -ca3 get"
    Invoke-SshCommand -SSHSession $Session -Command $CommandSNMPConfig
    Invoke-SshCommand -SSHSession $Session -Command 'snmpalerts -status on -crt all -crten enabled -wrn all -wrnen enabled -sys all -sysen enabled'
    Remove-SshSession -SSHSession $Session
    Write-Host "SNMP has been configured on $Server"
}
