#Join the Computer in the Active Directory from setup_ActiveDirectory.ps1
$domain = "sternig.net"
$user = "Administrator"
$password = Read-Host -Prompt "Enter password for $user" -AsSecureString
$username = "$domain\$user" 
Write-Output "Username: $username"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName $domain -Credential $credential