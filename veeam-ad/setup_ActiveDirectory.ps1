if (!(New-Object System.Security.Principal.WindowsPrincipal(
    [Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw 'this must run with Administrator privileges (e.g. in a elevated shell session)'
}
Write-Output "Enabling and install Active Directory..."
Install-WindowsFeature AD-Domain-Services
Write-Output "ADDSDeployment module initializing..."
Import-Module ADDSDeployment
Write-Output "Installing AD User Tools..."
Install-WindowsFeature RSAT-AD-PowerShell,RSAT-AD-AdminCenter,RSAT-ADDS-Tools

$ad_DomainName = "sternig.net"
$ad_NetbiosName = "STERNIG"
$Secure_String_Pwd = ConvertTo-SecureString "Mi24hind!" -AsPlainText -Force

Write-Output "Testing Active Directory..."
Test-ADDSForestInstallation -CreateDnsDelegation:$false -DomainMode Win2012R2 -DomainName $ad_DomainName -DomainNetbiosName $ad_NetbiosName -SafeModeAdministratorPassword $Secure_String_Pwd
Write-Output "Installing Active Directory..."
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode Win2012R2 -DomainName $ad_DomainName -DomainNetbiosName $ad_NetbiosName -ForestMode Win2012R2 -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -SafeModeAdministratorPassword $Secure_String_Pwd -Force:$true
