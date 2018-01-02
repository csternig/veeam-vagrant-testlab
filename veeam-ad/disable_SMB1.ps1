#Should run before Packer Script ./scripts/win-updates.ps1

if (!(New-Object System.Security.Principal.WindowsPrincipal(
    [Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw 'this must run with Administrator privileges (e.g. in a elevated shell session)'
}

Write-Output "Testing if SMB1 is active and installed..."
if (Get-WindowsFeature FS-SMB1) {
    Write-Output "SMB1 is active, removing the feature"
    Disable-WindowsOptionalFeature -Online -FeatureName smb1protocol
    }
	
	
	
